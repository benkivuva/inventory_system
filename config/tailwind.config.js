const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
    content: [
        './public/*.html',
        './app/helpers/**/*.rb',
        './app/javascript/**/*.js',
        './app/views/**/*.{erb,haml,html,slim}'
    ],
    theme: {
        extend: {
            colors: {
                'navy-dark': '#1E293B',
                'soft-gray': '#F8FAFC',
                'indigo-primary': '#6366F1',
                'emerald-success': '#10B981',
                'amber-warning': '#F59E0B',
                'rose-danger': '#F43F5E',
            },
            fontFamily: {
                sans: ['Inter var', ...defaultTheme.fontFamily.sans],
            },
        },
    },
    plugins: [
        require('@tailwindcss/forms'),
        require('@tailwindcss/typography'),
        require('@tailwindcss/container-queries'),
    ]
}
