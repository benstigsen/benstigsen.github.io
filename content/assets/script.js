/*
 * None of the JavaScript in this file, is necessary for the website to render or function.
 * It just brings a couple of nice features, when available.
 * - Codeblocks in `<pre class="copy"><code>`, get a button to copy the content.
 * - Headings like <h3> to level <h6>, get an ID and navigation link.
 * - Auto reload happens if running on localhost, if the fetched `/.reload` file has changed.
 */

 /**
  * @param {string} text Text to slugify, e.g. `Hello World!` becomes `hello-world`
  * @returns {string}
  */
function slugify(text) {
  const slug = text.toLowerCase().replaceAll(' ', '-').replace(/[^-a-z0-9]/gi, '');
  return slug.length > 32 ? slug.slice(0, 32) : slug;
}

document.addEventListener('DOMContentLoaded', () => {
  // Add IDs and links on h3 elements
  document.querySelectorAll('h3').forEach((element) => {
    const id = element.id || slugify(element.textContent);
    if (!element.id) {
      element.id = id;
    }

    element.innerHTML = `<a href="#${id}">${element.textContent}</a>`;
  })

  // Add copy button to <pre class="copy"><code> elements
  document.querySelectorAll('pre.copy code').forEach((element) => {
    const copy = document.createElement('button');
    copy.classList.add('copy-button');
    copy.innerText = 'CTRL + C';

    copy.onclick = () => {
      navigator.clipboard.writeText(element.textContent).then(
        () => { /* success */ },
        () => { /* error */ }
      );
    }

    element.closest('pre').appendChild(copy);
  });

  // Auto-reload when developing locally
  if (['localhost', '127.0.0.1'].includes(location.hostname)) {
    let token;

    setInterval(async () => {
      try {
        const res = await fetch('/.reload', { cache: 'no-store' });
        const next = await res.text();

        if (token !== undefined && token !== next) {
          location.reload();
        }

        token = next;
      } catch {
        // Server probably restarting; ignore.
      }
    }, 500);
  }
});
