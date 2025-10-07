local function fireAll()
    local args = {
         { 
            {
                currencyName = "Grass",
                amount = "1",
                max = "7",
                upgradeValue = "SpawnRate1",
                cost = "10" 
            }
        }
    }
    local args = {
	    {
	    	{
		    	currencyName = "Grass",
		    	amount = "1",
		    	max = "49",
		    	upgradeValue = "GrassAmount",
		    	cost = "3"
		    }
	    }
    }
    local args = {
	    {
		    {
			    currencyName = "Grass",
    			amount = "1",
	    		max = "99",
		     	upgradeValue = "GrassValue",
			    cost = "2"
	    	}
	    }
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Upgrade"):FireServer(unpack(args))
end

-- เรียกใช้ทุก 1 วินาที
while task.wait(0.1) do
    fireAll()
end
