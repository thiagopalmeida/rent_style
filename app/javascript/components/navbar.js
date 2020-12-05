const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.navbar-lewagon');
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= 300) {
        // window.innerHeight) {
        navbar.classList.add('navbar-lewagon-color');
      } else {
        navbar.classList.remove('navbar-lewagon-color');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };
