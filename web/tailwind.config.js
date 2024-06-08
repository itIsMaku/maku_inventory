/** @type {import('tailwindcss').Config} */
module.exports = {
    content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
    theme: {
        fontFamily: {
            main: ['Poppins', 'sans-serif']
        },
        container: {
            center: true,
            padding: '2rem',
            screens: {
                '2xl': '1400px'
            }
        },
        extend: {
            colors: {
                primary: 'var(--color-primary)',
            },
        }
    },
    plugins: [require('tailwindcss-animate')]
};
