# Weather Lockscreen Plugin for KOReader

A comprehensive KOReader plugin that displays beautiful weather information on your device's sleep screen.

![License](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)
![KOReader](https://img.shields.io/badge/KOReader-Plugin-orange.svg)

## Features

- **Real-time Weather Data** - Displays current weather conditions with icons, temperature, and detailed descriptions
- **Several Display Formats** - Choose from multiple layout options to suit your preferences
- **Easy Configuration** - Configure settings via main menu, no need to edit source code
- **Smart Caching** - Automatic caching with configurable expiration
- **Offline Support** - Uses cached data when internet connection is unavailable

## Display Modes

The plugin offers several display formats to customize your lockscreen:

### Cover Display
<img src="resources/cover.jpg" width="300">

### Detail Display
<img src="resources/detail.jpg" width="300">

### Minimal Display
<img src="resources/minimal.jpg" width="300">

### Retro Analog Display
<img src="resources/retro_analog.jpg" width="300">

### Night Owl Display
<img src="resources/night_owl.jpg" width="300">

## Installation

1. Download the latest release from the [Releases](https://github.com/loeffner/weatherlockscreen.koplugin/releases) page
2. Extract the `weatherlockscreen.koplugin` folder
3. Copy it to your KOReader plugins directory:
   - **Kindle**: `/mnt/us/koreader/plugins/`
   - **Kobo**: `/mnt/onboard/.adds/koreader/plugins/`
   - **Android**: `/sdcard/koreader/plugins/`
4. Restart KOReader

## Configuration

### Initial Setup

1. Navigate to **Main Menu > Weather Lockscreen > Settings**
2. Configure the following:
   - **Location**: Enter your location (city name, airport code, us postal code, or coordinates)
     - Examples: "London", "MUC", "10001", "48.8567,2.3508"
   - **Temperature Scale**: Choose Celsius (°C) or Fahrenheit (°F)
   - **Display Format**: Select your layout

### Enable Weather Display

1. Navigate to **Settings > Screen > Sleep screen > Wallpaper**
2. Select **"Show weather on sleep screen"**

## Requirements

- KOReader (latest version recommended)
- Active internet connection to fetch weather data

## How It Works

1. **Data Fetching**: Weather data is automatically fetched from WeatherAPI.com when your device enters sleep mode
2. **Caching**: Data is cached locally for a configurable amount of time (1h - 24h)
3. **Offline Mode**: If the API request fails or no internet connection is available, the plugin uses cached data
4. **Fallback Display**: If no cached data is available, displays a sun/moon icon based on the current time of day

## API Information

The plugin uses [WeatherAPI.com](https://www.weatherapi.com/)'s forecast endpoint. \
It uses my account and API Key. Please be responsible, otherwise I can not sustain this plugin. \
You can create your own account and API key at [WeatherAPI.com](https://www.weatherapi.com/).
The free tier allows 1 000 000 API calls per month.

<a href="https://www.weatherapi.com/" title="Free Weather API"><img src='//cdn.weatherapi.com/v4/images/weatherapi_logo.png' alt="Weather data by WeatherAPI.com" border="0"></a>

## Customization

### Custom Fallback Icons

You can customize the fallback sun/moon icons:

1. Create or download `sun.svg` and `moon.svg` icons
2. Place them in `<koreader_data_dir>/icons/`
3. The plugin will use these icons when weather data is unavailable

## Troubleshooting

### Weather not displaying
- Check your internet connection
- Ensure your location is entered correctly
- Check the KOReader log for error messages

### Icons not showing
- Ensure you have an active internet connection for the first fetch
- Weather icons are automatically downloaded and cached
- Check the cache directory has write permissions

### Outdated weather data
- Weather data is cached for 1 hour (default)
- Enter sleep mode again to force a refresh after the cache expires
- Check your internet connection

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Setup

1. Clone the repository
2. Make your changes
3. Test thoroughly on your KOReader device
4. Submit a pull request with a clear description of your changes

## Related Projects

- [KOReader](https://github.com/koreader/koreader) - The main KOReader project
- [WeatherAPI.com](https://www.weatherapi.com/) - Weather data provider

## Author

**Andreas Lösel**

## License

This project is licensed under the GNU Affero General Public License v3.0 - see the [LICENSE](LICENSE) file for details.
