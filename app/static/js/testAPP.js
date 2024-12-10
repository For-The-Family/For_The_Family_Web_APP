const vmodal = document.getElementById("item-closeup");
const root = document.getElementById("root");
const modal = document.querySelector("#modal");
const openModal = document.querySelector(".open-button");
const closeModal = document.querySelector(".close-button");
var coll = document.getElementsByClassName("collapsible");

const closeup = document.getElementById("item-closeup");
const overlay = document.getElementById("overlay");
const opencloseupBtn = document.querySelector(".btn-open");
const closecloseupBtn = document.querySelector(".btn-close");

let activitiesCheckboxes = [];
let CitiesCheckboxes = [];
let facilitiesCheckboxes = [];
let userCoordinates = null;




const icelandicOrder = [
    'A', 'Á', 'B', 'D', 'Ð', 'E', 'É', 'F', 'G', 'H', 'I', 'Í', 'J', 'K', 'L', 'M', 'N', 'O', 'Ó', 
    'P', 'R', 'S', 'T', 'U', 'Ú', 'V', 'X', 'Y', 'Ý', 'Þ', 'Æ', 'Ö'
];


sortingAB = true;
sortingGIO = false;

const getIndex = (char) => {
    const upperChar = char.toUpperCase();
    return icelandicOrder.indexOf(upperChar) !== -1 ? icelandicOrder.indexOf(upperChar) : 100;
};


for (i = 0; i < coll.length; i++) {
    coll[i].addEventListener("click", function() {
      this.classList.toggle("active");
      var content = this.nextElementSibling;
      if (content.style.display === "block") {
        content.style.display = "none";
      } else {
        content.style.display = "block";
      }
    });
  }


// This was the only way i could get the sorting to work i tryed 2 diffriend sorting systems one just did not work the other sorted right BUT Æ was just first 
const customSortAB = (a, b) => {
    let i = 0;
    while (i < a.name.length && i < b.name.length) {
        const aIndex = getIndex(a.name[i]);
        const bIndex = getIndex(b.name[i]);
        
        if (aIndex !== bIndex) {
            return aIndex - bIndex;
        }
        i++;
    }
    return a.name.length - b.name.length;
};


openModal.addEventListener('click', () => { 
    if (modal && typeof modal.showModal === 'function') {
        modal.showModal();
    }
});


closeModal.addEventListener('click', () => {
    if (modal && typeof modal.close === 'function') {
        modal.close();
    }
});





document.addEventListener('DOMContentLoaded', () => {
    createButtons();
    createcityCheckboxes();
    createActivityCheckboxes();
    createfacilitiesCheckboxes();
    if (sortingGIO) { 
    getUserLocation();}
});

const getItems = async () => {
    try {
        const response = await fetch('test_js/all');
        const data = await response.json();
return data;
    } catch (error) {
        document.querySelector('#message').innerText = 'Failed to load';
        return [];
    }
};

function createButtons() {
    const sortButtonContainer = document.createElement('div');
    sortButtonContainer.classList.add('grid', 'grid-cols-2', 'gap-4', 'p-4', 'mt-4');

    const sortByNameButton = document.createElement('button');
    sortByNameButton.innerText = 'Raða eftir nafni';
    sortByNameButton.classList.add(
        'bg-blue-500',
        'hover:bg-blue-700',
        'text-white',
        'text-lg',
        'font-bold',
        'py-2',
        'px-4',
        'rounded-full',
        'shadow-md'
    );
    sortByNameButton.addEventListener('click', () => {
        sortingAB = true;
        sortingGIO = false;
        updateDisplay();
    });

    const sortByGeolocationButton = document.createElement('button');
    sortByGeolocationButton.innerText = 'Raða eftir Geolocation';
    sortByGeolocationButton.classList.add(
        'bg-green-500',
        'hover:bg-green-700',
        'text-white',
        'text-lg',
        'font-bold',
        'py-2',
        'px-4',
        'rounded-full',
        'shadow-md'
    );
    sortByGeolocationButton.addEventListener('click', () => {
        sortingGIO = true;
        sortingAB = false;
        getUserLocation();
        updateDisplay();
    });

    sortButtonContainer.appendChild(sortByNameButton);
    sortButtonContainer.appendChild(sortByGeolocationButton);

    const filterContainer = document.querySelector('.grid.grid-cols-3.gap-4.p-4');
    filterContainer.insertAdjacentElement('afterend', sortButtonContainer);
}

async function createcityCheckboxes() {
    const items = await getItems();
    const Cities = items.reduce((acc, item) => {
        if (item.city && !acc.includes(item.city)) {
            acc.push(item.city);
        }
        return acc;
    }, []);

    const cityContainer = document.getElementById("city-filters");

    Cities.forEach(city => {
        let checkbox = document.createElement("input");
        checkbox.type = "checkbox";
        checkbox.id = city;
        checkbox.value = city;

        let label = document.createElement("label");
        label.htmlFor = city;
        label.innerText = city;

        cityContainer.appendChild(checkbox);
        cityContainer.appendChild(label);
        cityContainer.appendChild(document.createElement("br"));

        CitiesCheckboxes.push(checkbox);

        checkbox.addEventListener('change', updateDisplay);
    });
}

async function createActivityCheckboxes() {
    const items = await getItems();
    
    const uniqueActivities = new Set();
    items.forEach(item => {
        item.activities.forEach(activity => {
            uniqueActivities.add(activity.name);
        });
    });

    const activityContainer = document.getElementById("activity-filters");

    uniqueActivities.forEach(activityName => {

        let checkbox = document.createElement("input");
        checkbox.type = "checkbox";
        checkbox.id = activityName;
        checkbox.value = activityName;

        let label = document.createElement("label");
        label.htmlFor = activityName;
        if (activityName.trim() !== '') {
            label.innerText = activityName;
        }

        activityContainer.appendChild(checkbox);
        activityContainer.appendChild(label);
        activityContainer.appendChild(document.createElement("br"));

        activitiesCheckboxes.push(checkbox);

        checkbox.addEventListener('change', updateDisplay);
    });
}

async function createfacilitiesCheckboxes() {
    const items = await getItems();
    const facilities = items.reduce((acc, item) => {
        item.facilities.forEach(facility => {
            if (!acc.includes(facility)) {
                acc.push(facility);
            }
        });
        return acc;
    }, []);

    const facilityContainer = document.getElementById("facility-filters");

    facilities.forEach(facility => {
        let checkbox = document.createElement("input");
        checkbox.type = "checkbox";
        checkbox.id = facility;
        checkbox.value = facility;

        let label = document.createElement("label");
        label.htmlFor = facility;
        if (facility.trim() !== '') {
            label.innerText = facility;
        }

        facilityContainer.appendChild(checkbox);
        facilityContainer.appendChild(label);
        facilityContainer.appendChild(document.createElement("br"));

        facilitiesCheckboxes.push(checkbox);

        checkbox.addEventListener('change', updateDisplay);
    });
}




// start working 3:30 pm but i am sick so i will be slower i think

// first started to switch it to icelandic finished 3:55 pm and noticed forgot to make a project /:

// 3:55 pm started to make the Filter work... 4:30 pm There is no why I can fix this the SQL is the issue I have no idea how I can fix it

// 8:30 pm started compining the code

// 10:30 pm We ended since Jon had to go we would start at 8 tmr at school so we can finish the project

// 8:20 am started to work on the project again

// 10:20 am The others have left me i am still working

// 11:50 am I am going dowm to the others to see if they are ready

// 12:10 pm I am back to work!

// 12:40 pm class started

const opencloseup = (name, city, openingHours, minAge, activities, facilities, street_address) => {

    
    const uniqueActivities = [...new Set(activities.split(', ').map(item => item.trim()))];

    const contentHTML = `
        <h3>${name}</h3>
        <p><strong>Baearfelag:</strong> ${city}</p>
        <p><strong>Opnunartímar:</strong> ${openingHours}</p>
        <p><strong>Lágmarksaldur:</strong> ${minAge}</p>
        <p><strong>Götuheiti:</strong> ${street_address}</p>
        <p><strong>Virkni:</strong> ${uniqueActivities.join(', ') || 'Engin virkni í boði'}</p>
        <p><strong>Aðstaða:</strong> ${facilities || 'Food & Drinks, Parking, Toilets'}</p>
        <div id="map" class="map-container"></div>
    `;

    closeup.innerHTML = contentHTML;
    closeup.classList.remove("hidden");
    overlay.classList.remove("hidden");

    closeup.innerHTML = contentHTML;
    closeup.classList.remove("hidden");
    overlay.classList.remove("hidden");

    var map = L.map('map').setView([0, 0], 12);


    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);
    getUserLocation()



// THIS FEELS LIKE SPAGHETTI CODE BUT IT WORKS JUST BUY YOUR OWN MAP
    fetch(`https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(street_address)}`)
        .then(response => response.json())
        .then(data => {
            if (data && data.length > 0) {
                var lat = data[0].lat;
                var lon = data[0].lon;
                L.marker([lat, lon]).addTo(map)
                    .bindPopup("Götuheiti: " + street_address)
                    .openPopup();
                    if (userCoordinates) {
                        L.marker([userCoordinates.latitude, userCoordinates.longitude]).addTo(map)
                            .bindPopup("Þú ert hér")
                            .openPopup();
                    }
                    const distance = getDistanceFromUser(lat, lon).toFixed(2) + ' km'
                    const distanceElement = document.createElement('p');
                    if (distance === 'Infinity km') {
                        distanceElement.innerHTML = `<strong>Fjarlægð frá þér:</strong> Get ekki fundið eða slökkt`;
                    } else {
                        distanceElement.innerHTML = `<strong>Fjarlægð frá þér:</strong> ${distance}`;
                    }
                    closeup.appendChild(distanceElement);
            } else {
                const distanceElement = document.createElement('p');
                distanceElement.innerHTML = `<strong>Götuheiti ekki fundið`;
                closeup.appendChild(distanceElement);

            }
        })
};

const closeUpItems = document.querySelectorAll('.closeUp-item');
closeUpItems.forEach((item) => {
    item.addEventListener('click', () => {
        const name = item.dataset.name;
        const city = item.dataset.city;
        const openingHours = item.dataset.openingHours;
        const minAge = item.dataset.minAge;
        const activities = item.dataset.activities;
        const facilities = item.dataset.facilities;

        const street_address = item.dataset.street_address;

        opencloseup(name, city, openingHours, minAge, activities, facilities, street_address);
    });
});


const closecloseup = () => {
    closeup.classList.add("hidden");
    overlay.classList.add("hidden");
};
  
if (closecloseupBtn) {
    closecloseupBtn.addEventListener("click", closecloseup);
}
  
  overlay.addEventListener("click", closecloseup);

  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape" && !closeup.classList.contains("hidden")) {
        closecloseup();
    }
  });




const renderItems = (items) => {
    return items
        .map(({ name, city, opening_hours, minimum_age, image_path, activities, facilities, street_address }) => {
            const availableActivities = activities.filter(activity => activity.is_available).map(activity => activity.name);
            return `<li class="closeUp-item" data-street-address="${street_address}" data-name="${name}" data-city="${city}" data-opening-hours="${opening_hours}" data-min-age="${minimum_age}" data-activities="${availableActivities.join(', ')}" data-facilities="${facilities.join(', ')}">
                <h3>${name}</h3>
                <p><strong>Baearfelag:</strong> ${city}</p>
                <p><strong>Opnunartímar:</strong> ${opening_hours}</p>
                <img src="/static/${image_path}" alt="${name}" style="width: auto; height: auto; display: block; margin: auto; border: 3px solid #0f2027;">
            </li>`;
        })
        .join('');
};

const updateDisplay = async () => {
    const items = await getItems();
    if (items && items.length > 0) {
        const selectedActivities = activitiesCheckboxes.filter(checkbox => checkbox.checked).map(checkbox => checkbox.value);
        const selectedCities = CitiesCheckboxes.filter(checkbox => checkbox.checked).map(checkbox => checkbox.value);

        let sortedItems = items;
        if (sortingAB) {
            const sortedItems = items.sort(customSortAB);
        } else if (sortingGIO && userCoordinates) {
            sortedItems = sortedItems.filter(item => item.latitude && item.longitude)
            .sort((a, b) => {
                const distanceA = getDistanceFromUser(a.latitude, a.longitude);
                const distanceB = getDistanceFromUser(b.latitude, b.longitude);
                return distanceA - distanceB;
            });
        }

        sortedItems = sortedItems.filter(item => {
            const matchescity = selectedCities.length === 0 || selectedCities.includes(item.city);
            const matchesActivities = selectedActivities.every(activity => 
                item.activities.some(a => a.name === activity && a.is_available)
            );            const selectedFacilities = facilitiesCheckboxes.filter(checkbox => checkbox.checked).map(checkbox => checkbox.value);
            const matchesFacilities = selectedFacilities.every(facility => 
                item.facilities.includes(facility)
            );            return matchesActivities && matchescity && matchesFacilities;
        
        });

        const content = document.querySelector('#content');
        content.innerHTML = `<ul>${renderItems(sortedItems)}</ul>`;

        const closeUpItems = document.querySelectorAll('.closeUp-item');
        closeUpItems.forEach((item) => {
            item.addEventListener('click', () => {
                const name = item.dataset.name;
                const city = item.dataset.city;
                const openingHours = item.dataset.openingHours;
                const minAge = item.dataset.minAge;
                const activities = item.dataset.activities;
                const facilities = item.dataset.facilities;
                const street_address = item.dataset.streetAddress;

        
                opencloseup(name, city, openingHours, minAge, activities, facilities, street_address);
            });
        });
    }
};

const getUserLocation = () => {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            (position) => {
                userCoordinates = {
                    latitude: position.coords.latitude,
                longitude: position.coords.longitude
                };
            },
        );
    }
    else {sortingAB = true
        sortingGIO = false
        updateDisplay();
    }
};

const getDistanceFromUser = (lat2, lon2) => {
    if (!userCoordinates || lat2 === undefined || lon2 === undefined) {
        sortingAB = true
        sortingGIO = false
        return Infinity;
    }

    const lat1 = userCoordinates.latitude;
    const lon1 = userCoordinates.longitude;


    if (lat1 === undefined || lon1 === undefined || lat2 === undefined || lon2 === undefined) {
        return Infinity;
    }

    // This is from chatgpt I didn't find a good way to do this
    const toRadians = (degrees) => degrees * (Math.PI / 180);
    const R = 6371;
    const dLat = toRadians(lat2 - lat1);
    const dLon = toRadians(lon2 - lon1);
    const a =
        Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(toRadians(lat1)) * Math.cos(toRadians(lat2)) *
        Math.sin(dLon / 2) * Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    const distance = R * c;
    return distance;
};



(async () => {
    updateDisplay();
})();