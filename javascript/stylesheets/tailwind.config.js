// See the Tailwind default theme values here:
// https://github.com/tailwindcss/tailwindcss/blob/master/stubs/defaultConfig.stub.js
// Required inside postcss.config.js
const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
	important: true,
	plugins: [
		require('@tailwindcss/ui')({
		 layout: 'sidebar',
		})
	],

	experimental: {
	 experimental: 'all'
	},

	// All the default values will be compiled unless they are overridden below
	theme: {
		// Extend (add to) the default theme in the `extend` key
		extend: {
			// Create your own at: https://javisperez.github.io/tailwindcolorshades
			colors: {
				// Blue
				'primary': {
					// 50: '#EBF5FF',
					// 100: '#E1EFFD',
					// 200: '#A4CAFE',
					// 300: '#76A9FA',
					// 400: '#3F83F8',
					// 500: '#1C64F2',
					// 600: '#1A56DA',
					// 700: '#1656D8',
					// 800: '#1C429C',
					// 900: '#223874',
				},
				// Teal
				'secondary': {
					// 50: '#EDFAFA',
					// 100: '#D5F5F6',
					// 200: '#AFECEF',
					// 300: '#7EDCE2',
					// 400: '#16BDCA',
					// 500: '#0994A1',
					// 600: '#057481',
					// 700: '#046672',
					// 800: '#05505C',
					// 900: '#024451',
				},
				// Gray
				'tertiary': {
					// 50: '#F9FAFB',
					// 100: '#F4F5F7',
					// 200: '#E5E7EB',
					// 300: '#D2D6DC',
					// 400: '#9FA6B2',
					// 500: '#6B727F',
					// 600: '#4B5562',
					// 700: '#374150',
					// 800: '#252F3E',
					// 900: '#161E2D',
				},
				// Red
				'danger': {
					// 50: '#FDF2F2',
					// 100: '#FDE8E8',
					// 200: '#FBD5D5',
					// 300: '#F8B4B4',
					// 400: '#F98080',
					// 500: '#F05252',
					// 600: '#E02424',
					// 700: '#C81E1E',
					// 800: '#9B1C1C',
					// 900: '#771D1D',
				},
				// "code-400": "#F9FAFB",
				// "code-600": "#252F3E",
			},
		},
		// override the default theme using the key directly
		fontFamily: {
			sans: [
				"-apple-system",
				"BlinkMacSystemFont",
				'"Segoe UI"',
				"Roboto",
				'"Helvetica Neue"',
				"Arial",
				'"Noto Sans"',
				"sans-serif",
				'"Apple Color Emoji"',
				'"Segoe UI Emoji"',
				'"Segoe UI Symbol"',
				'"Noto Color Emoji"',
			],
		},
	},
	variants: {
		borderWidth: ['responsive', 'last', 'hover', 'focus'],
	},
}
