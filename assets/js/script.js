document.addEventListener("DOMContentLoaded", function() {
  fetch('/assets/art.json') // Adjust the path if your JSON file is in a different location
    .then(response => response.json())
    .then(art => {
      const haikus = art.haikus;
      const images = art.images;

      // Select a random haiku and image
      const randomHaikuIndex = Math.floor(Math.random() * haikus.length);
      const randomImageIndex = Math.floor(Math.random() * images.length);
      const randomHaiku = haikus[randomHaikuIndex];
      const randomImage = images[randomImageIndex];

      // Update the HTML content
      document.getElementById('haiku-container').innerHTML = `
        <p>${randomHaiku.content.replace(/\n/g, '<br>')}</p>
        <p><small>${randomHaiku.date} - ${randomHaiku.number}</small></p>
      `;
      document.getElementById('image-container').innerHTML = `<img src="${randomImage}" alt="Random Image">`;
    })
    .catch(error => console.error('Error fetching the data:', error));
});
