const vmodal = document.getElementById("item-modal");
const overlay = document.getElementById("overlay");
const root = document.getElementById("root");
const modal = document.querySelector("#modal");
const openModal = document.querySelector(".open-button");
const closeModal = document.querySelector(".close-button");
var coll = document.getElementsByClassName("collapsible");
var i;



let activitiesCheckboxes = [];
let CitiesCheckboxes = [];
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
    while (i < a.Name.length && i < b.Name.length) {
        const aIndex = getIndex(a.Name[i]);
        const bIndex = getIndex(b.Name[i]);
        
        if (aIndex !== bIndex) {
            return aIndex - bIndex;
        }
        i++;
    }
    return a.Name.length - b.Name.length;
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
    createCityCheckboxes();
    createActivityCheckboxes();
    createNearbyFacilitiesCheckboxes();
    if (sortingGIO) { 
    getUserLocation();}
});

const getItems = async () => {
    try {
        const response = await fetch('../../static/data/kindergarten_rvk.json');
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

async function createCityCheckboxes() {
    const items = await getItems();
    const Cities = items.reduce((acc, item) => {
        if (item.Location && item.Location.City && !acc.includes(item.Location.City)) {
            acc.push(item.Location.City);
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
        Object.keys(item.AvailableActivities).forEach(activity => {
            if (!acc.includes(activity)) {
                acc.push(activity);
            }
        });
        return acc;
    }, []);

    const activityContainer = document.getElementById("activity-filters");

    activities.forEach(activity => {
        let checkbox = document.createElement("input");
        checkbox.type = "checkbox";
        checkbox.id = activity;
        checkbox.value = activity;

        let label = document.createElement("label");
        label.htmlFor = activity;
        label.innerText = activity;

        activityContainer.appendChild(checkbox);
        activityContainer.appendChild(label);
        activityContainer.appendChild(document.createElement("br"));

        activitiesCheckboxes.push(checkbox);

        checkbox.addEventListener('change', updateDisplay);
    });
}

async function createNearbyFacilitiesCheckboxes() {
    const items = await getItems();
    const facilities = items.reduce((acc, item) => {
        Object.keys(item.NearbyFacilities).forEach(facility => {
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

let facilitiesCheckboxes = [];

const renderItems = (items) => {
    return items
        .map(({ Name, Location, OpeningHours, MinimumAge, Image, AvailableActivities, NearbyFacilities }) =>
            `<li class="coaster-item">
                <h3>${Name}</h3>
                <img src="${Image}" alt="${Name}" style="width: 200px; height: auto;">
            </li>`
        )
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
            const matchesCity = selectedCities.length === 0 || selectedCities.includes(item.Location.City);
            const matchesActivities = selectedActivities.every(activity => item.AvailableActivities[activity]);
            const selectedFacilities = facilitiesCheckboxes.filter(checkbox => checkbox.checked).map(checkbox => checkbox.value);
            const matchesFacilities = selectedFacilities.every(facility => item.NearbyFacilities[facility]);
            return matchesActivities && matchesCity && matchesFacilities;
        });

        const content = document.querySelector('#content');
        content.innerHTML = `<ul>${renderItems(sortedItems)}</ul>`;
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
