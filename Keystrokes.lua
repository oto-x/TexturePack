if game:GetService("CoreGui"):FindFirstChild("KEYS") then
				game:GetService("CoreGui"):FindFirstChild("KEYS"):Destroy()
			end
			wait(1)
			local ScreenGui = Instance.new("ScreenGui")
			ScreenGui.Parent =  game:GetService("CoreGui")
			ScreenGui.Name = 'KEYS'
			local keystroke = Instance.new("Frame")
			local AKey = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local ALabel = Instance.new("TextLabel")
			local SKey = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local SLabel = Instance.new("TextLabel")
			local DKey = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")
			local DLabel = Instance.new("TextLabel")
			local WKey = Instance.new("Frame")
			local UICorner_4 = Instance.new("UICorner")
			local WLabel = Instance.new("TextLabel")
			local SpaceBar = Instance.new("Frame")
			local UICorner_5 = Instance.new("UICorner")
			local SpaceBarLabel = Instance.new("TextLabel")
			
			keystroke.Name = "keystroke"
			keystroke.Parent = ScreenGui
			keystroke.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			keystroke.BackgroundTransparency = 1.000
			keystroke.Position = UDim2.new(-0.00722312089, 0, 0.690598845, 0)
			keystroke.Size = UDim2.new(0, 285, 0, 287)
			
			AKey.Name = "AKey"
			AKey.Parent = keystroke
			AKey.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
			AKey.BackgroundTransparency = 0.450
			AKey.Position = UDim2.new(0.0454545468, 0, 0.536585391, 0)
			AKey.Size = UDim2.new(0, 49, 0, 49)
			
			UICorner.Parent = AKey
			
			ALabel.Name = "ALabel"
			ALabel.Parent = AKey
			ALabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ALabel.BackgroundTransparency = 1.000
			ALabel.Position = UDim2.new(-0.142857075, 0, 0, 0)
			ALabel.Size = UDim2.new(0, 62, 0, 50)
			ALabel.Font = Enum.Font.FredokaOne
			ALabel.Text = "A"
			ALabel.TextColor3 = Color3.fromRGB(77, 107, 149)
			ALabel.TextSize = 32.000
			
			SKey.Name = "SKey"
			SKey.Parent = keystroke
			SKey.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
			SKey.BackgroundTransparency = 0.450
			SKey.Position = UDim2.new(0.238436997, 0, 0.536585391, 0)
			SKey.Size = UDim2.new(0, 49, 0, 49)
			
			UICorner_2.Parent = SKey
			
			SLabel.Name = "SLabel"
			SLabel.Parent = SKey
			SLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SLabel.BackgroundTransparency = 1.000
			SLabel.Position = UDim2.new(-0.122448914, 0, -0.0204081628, 0)
			SLabel.Size = UDim2.new(0, 62, 0, 50)
			SLabel.Font = Enum.Font.FredokaOne
			SLabel.Text = "S"
			SLabel.TextColor3 = Color3.fromRGB(77, 107, 149)
			SLabel.TextSize = 32.000
			
			DKey.Name = "DKey"
			DKey.Parent = keystroke
			DKey.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
			DKey.BackgroundTransparency = 0.450
			DKey.Position = UDim2.new(0.431419432, 0, 0.540069699, 0)
			DKey.Size = UDim2.new(0, 49, 0, 49)
			
			UICorner_3.Parent = DKey
			
			DLabel.Name = "DLabel"
			DLabel.Parent = DKey
			DLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DLabel.BackgroundTransparency = 1.000
			DLabel.Position = UDim2.new(-0.142857015, 0, 0, 0)
			DLabel.Size = UDim2.new(0, 62, 0, 50)
			DLabel.Font = Enum.Font.FredokaOne
			DLabel.Text = "D"
			DLabel.TextColor3 = Color3.fromRGB(77, 107, 149)
			DLabel.TextSize = 32.000
			
			WKey.Name = "WKey"
			WKey.Parent = keystroke
			WKey.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
			WKey.BackgroundTransparency = 0.450
			WKey.Position = UDim2.new(0.238436982, 0, 0.347000003, 0)
			WKey.Size = UDim2.new(0, 49, 0, 49)
			
			UICorner_4.Parent = WKey
			
			WLabel.Name = "WLabel"
			WLabel.Parent = WKey
			WLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			WLabel.BackgroundTransparency = 1.000
			WLabel.Position = UDim2.new(-0.122448921, 0, -0.00204081833, 0)
			WLabel.Size = UDim2.new(0, 62, 0, 50)
			WLabel.Font = Enum.Font.FredokaOne
			WLabel.Text = "W"
			WLabel.TextColor3 = Color3.fromRGB(77, 107, 149)
			WLabel.TextSize = 32.000
			
			SpaceBar.Name = "SpaceBar"
			SpaceBar.Parent = keystroke
			SpaceBar.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
			SpaceBar.BackgroundTransparency = 0.450
			SpaceBar.Position = UDim2.new(0.0454544872, 0, 0.742160261, 0)
			SpaceBar.Size = UDim2.new(0, 161, 0, 31)
			
			UICorner_5.Parent = SpaceBar
			
			SpaceBarLabel.Name = "SpaceBarLabel"
			SpaceBarLabel.Parent = SpaceBar
			SpaceBarLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SpaceBarLabel.BackgroundTransparency = 1.000
			SpaceBarLabel.Position = UDim2.new(0.304347903, 0, -0.806451619, 0)
			SpaceBarLabel.Size = UDim2.new(0, 62, 0, 50)
			SpaceBarLabel.Font = Enum.Font.FredokaOne
			SpaceBarLabel.Text = "_____"
			SpaceBarLabel.TextColor3 = Color3.fromRGB(77, 107, 149)
			SpaceBarLabel.TextSize = 32.000
			
			local UserInputService = game:GetService("UserInputService")
			
			getgenv().keys = {
				['Space'] = false;
				['W'] = false;
				['A'] = false;
				['S'] = false;
				['D'] = false;
			}
			
			local wButton = WKey
			
			
			local litColor = Color3.fromRGB(220, 208, 255)
			
			
			local unlitColor = Color3.fromRGB(34, 34, 34)
			
			
			UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if not gameProcessed then
					
					if input.KeyCode == Enum.KeyCode.W then
						if wButton.BackgroundColor3 ~= litColor then
							wButton.BackgroundColor3 = litColor
						end
					end
				end
			end)
			
			
			UserInputService.InputEnded:Connect(function(input, gameProcessed)
				if not gameProcessed then
					
					if input.KeyCode == Enum.KeyCode.W then
						if wButton.BackgroundColor3 ~= unlitColor then
			
							wButton.BackgroundColor3 = unlitColor
						end
					end
				end
			end)
			
			
			
			local dButton = DKey
			
			
			UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if not gameProcessed then
					
					if input.KeyCode == Enum.KeyCode.D then
						if dButton.BackgroundColor3 ~= litColor then
						dButton.BackgroundColor3 = litColor
						end
					end
				end
			end)
			
			
			UserInputService.InputEnded:Connect(function(input, gameProcessed)
				if not gameProcessed then
					
					if input.KeyCode == Enum.KeyCode.D then
						if dButton.BackgroundColor3 ~= unlitColor then
						dButton.BackgroundColor3 = unlitColor
						end
					end
				end
			end)
			
			
			local aButton = AKey
			
			
			UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if not gameProcessed then
					
					if input.KeyCode == Enum.KeyCode.A then
						if aButton.BackgroundColor3 ~= litColor then
						aButton.BackgroundColor3 = litColor
						end
					end
				end
			end)
			
			
			UserInputService.InputEnded:Connect(function(input, gameProcessed)
				if not gameProcessed then
					
					if input.KeyCode == Enum.KeyCode.A then
						if aButton.BackgroundColor3 ~= unlitColor then
						aButton.BackgroundColor3 = unlitColor
						end
					end
				end
			end)
			
			
			
			local sButton = SKey
			
			
			
			UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if not gameProcessed then
					
					if input.KeyCode == Enum.KeyCode.S then
						if sButton.BackgroundColor3 ~= litColor then
							sButton.BackgroundColor3 = litColor
						end
					end
				end
			end)
			
			
			UserInputService.InputEnded:Connect(function(input, gameProcessed)
				if not gameProcessed then
					
					if input.KeyCode == Enum.KeyCode.S then
					if sButton.BackgroundColor3 ~= unlitColor then    
						sButton.BackgroundColor3 = unlitColor
					end
					end
				end
			end)
			
			
			local spaceButton = SpaceBar
			
			UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if not gameProcessed then
					
					if input.KeyCode == Enum.KeyCode.Space then
					if spaceButton.BackgroundColor ~= litColor then
						spaceButton.BackgroundColor3 = litColor
					end
					end
				end
			end)
			
			
			UserInputService.InputEnded:Connect(function(input, gameProcessed)
				if not gameProcessed then
					
					if input.KeyCode == Enum.KeyCode.Space then
					if spaceButton.BackgroundColor ~= unlitColor then
						spaceButton.BackgroundColor3 = unlitColor
					end
					end
				end
			end)
