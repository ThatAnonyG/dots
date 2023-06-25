local os = require("os")

return {
	cmd = { os.getenv("HOME") .. "/.cargo/bin/rust-analyzer" },
}
