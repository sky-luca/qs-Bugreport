
# Bug Reporting System for FiveM

This is a **Bug Reporting System** designed for FiveM servers. It allows players to submit bug reports with detailed information, and administrators can manage these reports efficiently through a custom interface. The system integrates with **ox_lib** for the menu and notifications, and it sends detailed logs of each bug report to a **Discord channel** for better tracking.

## Features

- **Bug Report Menu**: Players can open a menu to submit their bug reports easily.
- **Bug Report Creation**: Players can include details like the bug description, steps to reproduce, category, priority, contact information, and coordinates.
- **Admin Notifications**: Admins are notified via an on-screen notification when a new bug report is created.
- **Discord Logging**: Each bug report is logged in a designated Discord channel with an embed that includes important report details.
- **Bug Report Status Management**: Admins can update the status of bug reports to keep track of progress.

## Setup Instructions

### 1. Install Dependencies

Make sure that the following dependencies are installed and configured:

- **ox_lib** for menu handling and notifications.
  
You can install it via the FiveM resource manager.

### 2. Configure Permissions

The system uses **ACE permissions** to manage access to the bug reporting functionalities. Ensure that the permission `bugreport.notify` is granted to admins for managing the reports.

You can configure the permissions in the server's `server.cfg` file or using the **Add_ace** command in the console.

### 3. Configuration File

In the script’s configuration file (`config.lua`), set your **Discord Webhook URL** to enable the Discord logging feature.

Example:

```lua
Config = {
    WebhookURL = "YOUR_DISCORD_WEBHOOK_URL"
}
```

### 4. Installing and Running the Script

Once the script and dependencies are configured, add the bug reporting script to your `resources` folder and start it on the server.

In your `server.cfg` file:

```bash
start qs-bugreport
```

### 5. Permissions

Admins must have the `bugreport.notify` permission to use the bug report management features. You can adjust the permissions as needed by adding them in the server configuration.

## Commands

- **/bugreport**: Opens the bug report menu for players. Players will be able to submit bug reports through this menu.
- **/bugreportsetstatus [ticketId]**: Allows admins to set the status of a specific bug report by using its ID.

### Example Usage

1. **Player submits a bug report**:
   - Players can use `/bugreport` to open the bug report menu.
   - They will fill out the form with details such as:
     - Bug description
     - Steps to reproduce the bug
     - Category and priority
     - Contact info
     - Coordinates (if applicable)

2. **Admin sets the status of a bug report**:
   - Admins can use `/bugreportsetstatus [ticketId]` to open a menu that allows them to manage the status of the bug report.

## Discord Integration

Each bug report will be logged in a Discord channel, and the details will be sent as an embed to help admins track the issue. The Discord log includes:

- Bug report ID
- Bug description
- Steps to reproduce
- Category
- Priority
- Contact info
- Coordinates (if provided)

The logs provide admins with a complete overview of the bug reports in real time.

## Error Handling

Errors during bug report submission are logged to the server’s console. If something goes wrong (e.g., invalid ticket ID or permission issues), a notification will be sent to the player or admin in the game.

## License

This project is licensed under the **License**. You are free to modify and redistribute the code as you see fit, provided that you include the original license.

## Support

If you have any issues or need help, feel free to open an issue on the GitHub repository or contact the developer:

- **Developer**: luca_112
- **Website**: https://www.qs-scripts.com
- **Discord**: https://discord.gg/zXB37WgjcW

