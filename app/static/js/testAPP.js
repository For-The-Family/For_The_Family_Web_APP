const vmodal = document.getElementById("item-closeup");
const root = document.getElementById("root");
const modal = document.querySelector("#modal");
const openModal = document.querySelector(".open-button");
const closeModal = document.querySelector(".close-button");
var coll = document.getElementsByClassName("collapsible");

const closeup = document.getElementById("item-closeup");
const overlay = document.getElementById("overlay");
const openCloesupBtn = document.querySelector(".btn-open");
const closeCloesupBtn = document.querySelector(".btn-close");

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
    } else {
        console.error('Modal element does not support showModal method');
    }
});

closeModal.addEventListener('click', () => {
    if (modal && typeof modal.close === 'function') {
        modal.close();
    } else {
        console.error('Modal element does not support close method');
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
        console.error('Failed to load data', error);
        document.querySelector('#message').innerText = 'Failed to load';
        return [];
    }
};

function createButtons() {
    const sortByNameButton = document.createElement('button');
    sortByNameButton.innerText = 'Sort by name';
    sortByNameButton.addEventListener('click', () => {
        sortingAB = true;
        sortingGIO = false;
        updateDisplay();
    });

    const sortByGeolocationButton = document.createElement('button');
    sortByGeolocationButton.innerText = 'Sort by Geolocation';
    sortByGeolocationButton.addEventListener('click', () => {
        sortingGIO = true;
        sortingAB = false;
        getUserLocation()
        updateDisplay();
    });

    root.appendChild(sortByNameButton);
    root.appendChild(sortByGeolocationButton);
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
    const activities = items.reduce((acc, item) => {
        item.activities.forEach(activity => {
            if (!acc.includes(activity)) {
                console.log(activity);
                acc.push(activity);
            }
        });
        return acc;
    }, []);

    const activityContainer = document.getElementById("activity-filters");

    activities.forEach(activities => {
        let checkbox = document.createElement("input");
        checkbox.type = "checkbox";
        checkbox.id = activities;
        checkbox.value = activities;

        let label = document.createElement("label");
        label.htmlFor = activities;
        label.innerText = activities;

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
        label.innerText = facility;

        facilityContainer.appendChild(checkbox);
        facilityContainer.appendChild(label);
        facilityContainer.appendChild(document.createElement("br"));

        facilitiesCheckboxes.push(checkbox);

        checkbox.addEventListener('change', updateDisplay);
    });
}



// this is for the map took 1 hour and 40 min, 4:00 - 5:40
// adding the rest of the items took me 30 min 5:40 - 6:10
// Taking a time off coding 6:10 - 7:00 to think of what i can do next if you don't think this counts i will be :(
// Want to make kindergardens and schools next BUT i don't have the data But the answer should be easy
// Things i can do are
// 1. Make a counter in map when clicks shows how far you are
// 2. if we have filter for kindergardens and schools we can make a filter for them asking in discord
// fixed a small bug
// 3. clean up the code i guess
// 4. Make a new js just so the popup happens at the starter page
// 5. My brain is not working :( 
// Just been told 2 won't happen and 1 would not but am still gonna make the code for 1 so i can show i have been doing anything
// 6. guess i could make a search bar but we agreed to not do that

// it's now 7:00 i have food now for a real brake


// Some extra stuff so i can't be called out we agreed to remove the local storage raiting since we don't have the time to do it
// Also i could just add an @ after the map where they could ask to remove

// 7:45 back from a brake was asked to switch lat and lng to street address if this work would be a waste of my time :(
// 7:50 found out how to do it with street address just need to make it work
// 8:40 in a call with dillia 
// 8:55 Got the street map to to work
// 9:00 Starting working on 1 sees how far you are
// 9:50 Done with the distance from user to target even added a mark just don't look at the code

const openCloesup = (name, city, openingHours, minAge, activities, facilities, street_address) => {
    
    
    const contentHTML = `
        <h3>${name}</h3>
        <p><strong>City:</strong> ${city}</p>
        <p><strong>Opening Hours:</strong> ${openingHours}</p>
        <p><strong>Minimum Age:</strong> ${minAge}</p>
        <p><strong>Activities:</strong> ${activities}</p>
        <p><strong>Facilities:</strong> ${facilities}</p>
        <div id="map" class="map-container"></div>
    `;

    closeup.innerHTML = contentHTML;
    closeup.classList.remove("hidden");
    overlay.classList.remove("hidden");

    var map = L.map('map').setView([51.505, -0.09], 13);


    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);
    getUserLocation()



// THIS FEELS LIKE SPAGHETTI CODE BUT IT WORKS JUST BUY YOUR OWN MAP
    console.log(street_address);
    fetch(`https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(street_address)}`)
        .then(response => response.json())
        .then(data => {
            if (data && data.length > 0) {
                var lat = data[0].lat;
                var lon = data[0].lon;
                L.marker([lat, lon]).addTo(map)
                    .bindPopup("Address: " + street_address)
                    .openPopup();
                    if (userCoordinates) {
                        L.marker([userCoordinates.latitude, userCoordinates.longitude]).addTo(map)
                            .bindPopup("You are here")
                            .openPopup();
                    }
                    console.log(lat, lon);
                    console.log(userCoordinates);
                    const distance = getDistanceFromUser({ Latitude: lat, Longitude: lon }).toFixed(2) + ' km'
                    const distanceElement = document.createElement('p');
                    if (distance === 'Infinity km') {
                        distanceElement.innerHTML = `<strong>Distance from you:</strong> Can't locate or turned off geo`;
                    } else {
                        distanceElement.innerHTML = `<strong>Distance from you:</strong> ${distance}`;
                    }
                    closeup.appendChild(distanceElement);
            } else {
                console.error("Address not found!");
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

        openCloesup(name, city, openingHours, minAge, activities, facilities, street_address);
    });
});


const closeCloesup = () => {
    closeup.classList.add("hidden");
    overlay.classList.add("hidden");
};
  
if (closeCloesupBtn) {
    closeCloesupBtn.addEventListener("click", closeCloesup);
}
  
  overlay.addEventListener("click", closeCloesup);

  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape" && !closeup.classList.contains("hidden")) {
        closeCloesup();
    }
  });
  //



  const renderItems = (items) => {
    return items
        .map(({ name, city, opening_hours, minimum_age, image_path, activities, facilities, street_address }) =>
            `<li class="closeUp-item" data-street-address="${street_address}" data-name="${name}" data-city="${city}" data-opening-hours="${opening_hours}" data-min-age="${minimum_age}" data-activities="${activities.join(', ')}" data-facilities="${facilities.join(', ')}">
                <h3>${name}</h3>
                <p><strong>City:</strong> ${city}</p>
                <p><strong>Opening Hours:</strong> ${opening_hours}</p>
                <img src="/static/${image_path}" alt="${name}" style="width: 200px; height: auto;">
            </li>`
        )
        .join('');
};

const updateDisplay = async () => {
    const items = await getItems();
    console.log(items);
    if (items && items.length > 0) {
        const selectedActivities = activitiesCheckboxes.filter(checkbox => checkbox.checked).map(checkbox => checkbox.value);
        const selectedCities = CitiesCheckboxes.filter(checkbox => checkbox.checked).map(checkbox => checkbox.value);

        let sortedItems = items;
        if (sortingAB) {
            const sortedItems = items.sort(customSortAB);
            console.log(sortedItems);
        } else if (sortingGIO && userCoordinates) {
            console.log("START SORTING GIO")
            sortedItems = sortedItems.filter(item => item.Location && item.Location.GeoLocation)
            .sort((a, b) => {
                const distanceA = getDistanceFromUser(a.Location.GeoLocation);
                const distanceB = getDistanceFromUser(b.Location.GeoLocation);
                console.log('Distances:', distanceA, distanceB);
                return distanceA - distanceB;
            });
        }

        sortedItems = sortedItems.filter(item => {
            const matchescity = selectedCities.length === 0 || selectedCities.includes(item.city);
            const matchesActivities = selectedActivities.every(activities => item.activities.is_available[activities]);
            const selectedFacilities = facilitiesCheckboxes.filter(checkbox => checkbox.checked).map(checkbox => checkbox.value);
            const matchesFacilities = selectedFacilities.every(facility => item.facilities.is_available[facility]);
            return matchesActivities && matchescity && matchesFacilities;
        
        });

        const content = document.querySelector('#content');
        content.innerHTML = `<ul>${renderItems(sortedItems)}</ul>`;

        //this is from old code
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
                console.log(street_address);
                console.log(item);
        
                openCloesup(name, city, openingHours, minAge, activities, facilities, street_address);
            });
        });
    } else {
        console.error('No items to display');
    }
};

const getUserLocation = () => {
    console.log("test");
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            (position) => {
                userCoordinates = {
                    latitude: position.coords.latitude,
                longitude: position.coords.longitude
                };
                console.log(userCoordinates);
                updateDisplay();
            },
        );
    }
    else {sortingAB = true
        sortingGIO = false
        updateDisplay();
    }
};

const getDistanceFromUser = (targetCoordinates) => {
    if (!userCoordinates || !targetCoordinates) {
        console.warn('STUCK FUCLKING IF SEE THIS MEANS CANT SEE THE OBJECTS CORDS OR USERS', { userCoordinates, targetCoordinates });
        sortingAB = true
        sortingGIO = false
        updateDisplay();
        return Infinity;
    }

    const lat1 = userCoordinates.latitude;
    const lon1 = userCoordinates.longitude;
    const lat2 = targetCoordinates.Latitude;
    const lon2 = targetCoordinates.Longitude;

    if (lat1 === undefined || lon1 === undefined || lat2 === undefined || lon2 === undefined) {
        console.warn('One of the coordinates is undefined:', { lat1, lon1, lat2, lon2 });
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
    console.log(`Distance from user to target: ${distance} km`);
    return distance;
};



(async () => {
    updateDisplay();
})();