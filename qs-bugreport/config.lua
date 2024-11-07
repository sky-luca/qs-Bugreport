-- config.lua (shared file, used both client and server)
Config = {}

Config.WebhookURL = "https://discord.com/api/webhooks/1304082655020580894/xmNS58ZEQAJLZW7LtwTAkajxU1nVDvoIeKrHC_qJXkg1y2LlwtOnr7n2NK327SaRm6ms"
Config.Messages = {
    bugReportTitle = "Bug Report",
    bugReportDescription = "Player %s [%d] reported a bug: %s\nSteps to reproduce: %s\nReport ID: %d",
    errorInputBugDescription = "Please provide a description of the bug.",
    cancelBugReport = "Bug report has been cancelled."
}
Config.PermissionGroups = { "admin", "superadmin", "mod", "supporter" }
