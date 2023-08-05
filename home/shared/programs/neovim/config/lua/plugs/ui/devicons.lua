local devicons = require("nvim-web-devicons")

local config = {
    override = {
        c = { icon = "", name = "C" },
        css = { icon = "", name = "CSS" },
        deb = { icon = "", name = "Deb" },
        Dockerfile = {
            icon = "",
            name = "Dockerfile",
        },
        md = { icon = "" },
        html = { icon = "", name = "HTML" },
        jpeg = { icon = " ", name = "JPEG" },
        jpg = { icon = " ", name = "JPG" },
        js = { icon = " ", name = "JS" },
        kt = { icon = "", name = "Kt" },
        lock = { icon = "󰌾", name = "Lock" },
        mp3 = { icon = "󰎈", name = "MP3" },
        mp4 = { icon = "", name = "MP4" },
        out = { icon = "", name = "Out" },
        png = { icon = "", name = "PNG" },
        py = { icon = "", name = "Py" },
        rust = { icon = "󱘗", name = "Rust" },
        ["robots.txt"] = {
            icon = "󱚣",
            name = "robots",
        },
        toml = { icon = "", name = "TOML" },
        ts = { icon = "󰛦", name = "TS" },
        ttf = {
            icon = "",
            name = "TrueTypeFont",
        },
        rb = { icon = "󰴭" },
        yuck = { icon = "󰇷", name = "Yuck" },
        vim = { icon = "", name = "Vim" },
        rpm = { icon = "", name = "RPM" },
        vue = { icon = "󰡄", name = "Vue" },
        woff = {
            icon = "",
            name = "WebOpenFontFormat",
        },
        woff2 = {
            icon = "",
            name = "WebOpenFontFormat2",
        },
        xz = { icon = "", name = "XZ" },
        zip = { icon = "", name = "Zip" },
    },
    default = true,
}

devicons.set_default_icon("󰈚")
devicons.setup(config)
