local schemas = {
	["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.y{a,}ml",
}

return {
	settings = {
		yaml = {
			schemas = schemas,
			keyOrdering = false,
		},
	},
}
