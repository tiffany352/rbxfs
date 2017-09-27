if (not plugin) then
	return
end

local HttpService = game:GetService("HttpService")

local function main()
	local address = "localhost"
	local port = 8001

	local remote = ("http://%s:%d/fs"):format(address, port)

	local toolbar = plugin:CreateToolbar("rbxfs 2.0")

	toolbar:CreateButton("Connect", "Connect to RBXFS Instance", "")
		.Click:Connect(function()
			local infoUrl = ("%s/info"):format(remote)
			local result = HttpService:JSONDecode(HttpService:GetAsync(infoUrl))

			print(("Connected!\nServer version: %s\nProtocol version: %s"):format(
				result.server_version,
				result.protocol_version
			))
		end)

	toolbar:CreateButton("Download", "Download (Testing)", "")
		.Click:Connect(function()
			local readAllUrl = ("%s/read-all"):format(remote)
			local result = HttpService:GetAsync(readAllUrl)

			print("download:", result)
		end)
end

main()