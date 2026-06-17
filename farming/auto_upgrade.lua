local function fireAll()
    local args = {
	vector.create(25.944355010986328, 189.75001525878906, 249.5)
    }
    workspace:WaitForChild("Tycoons"):WaitForChild("Tycoon3"):WaitForChild("Drop"):FireServer(unpack(args))

-- เรียกใช้ทุก 1 วินาที
while task.wait(0.1) do
    fireAll()
end
