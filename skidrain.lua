local args = {
    [1] = "_lobbytemplate210"
}

game:GetService("ReplicatedStorage").endpoints.client_to_server.request_matchmaking:InvokeServer(unpack(args))
