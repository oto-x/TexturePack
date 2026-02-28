local backupText = {
			"Pista!",
			"W!",
			"Wham!",
			"Hit!",
			"Smack!",
			"Thump!",
			"Pop!",
			"Pow!",
		}

local NewHighlightController = {
			entityCleanup = {}
		}
		local bedwarsMaid = debug.getupvalue(getmetatable(bedwars.HighlightController).highlight, 1)
		
		local function highlightPartNew(character, color, texture)
			local highlighted = {}
			for key, side in next, (Enum.NormalId:GetEnumItems()) do
				local name = "entity-highlight-texture:" .. tostring(side.Value)
				local highlight = character:FindFirstChild(name)
				if not highlight then
					highlight = Instance.new("Texture")
					highlight.Name = name
					highlight.Face = side
					highlight.Parent = character
				end
				highlight.Texture = texture or "rbxassetid://5090332523"
				highlight.Color3 = color or Color3.new(1, 0, 0)
				highlight.Transparency = OldHighlight.Enabled and 0.1 or 0.4
				table.insert(highlighted, highlight)	
			end
			return highlighted
		end
		local function highlightNew(character, configTable)
			if configTable == nil then
				configTable = {}
			end
			local cleaner = NewHighlightController.entityCleanup[character]
			if cleaner then
				cleaner:DoCleaning()
			end
			local highlightMaid = bedwarsMaid.new()
			NewHighlightController.entityCleanup[character] = highlightMaid
			local canHighlight = true
			highlightMaid:GiveTask(function()
				canHighlight = false
			end)
			local highlightObjects = {}
			for i, v in next, character:GetDescendants() do
				if v:IsA("BasePart") and (configTable.shouldApplyToPart == nil or configTable.shouldApplyToPart(v)) and v.Transparency ~= 1 then
					local newparts = highlightPartNew(character, configTable.color, configTable.textureId)
					highlightMaid:GiveTask(function()
						table.clear(newparts)
					end)
					for _, object in next, newparts do
						table.insert(highlightObjects, object)
					end
				end
			end
			local transparencyValue = bedwars.make("NumberValue", {
				Value = ((configTable.fadeInTime or 0) <= 0 and configTable.transparency or (OldHighlight.Enabled and 0.1) or 0.4) or 1
			})
			local function checkHighlight()
				for _, object in next, highlightObjects do
					if not object.Parent then
						table.remove(highlightObjects, table.find(highlightObjects, object))
					else
						object.Transparency = transparencyValue.Value
					end
				end
			end
			local transparencyConnection = transparencyValue.Changed:Connect(checkHighlight)
			checkHighlight()
			highlightMaid:GiveTask(function()
				transparencyConnection:Disconnect()
				transparencyValue:Destroy()
			end)
			task.spawn(function()
				if (configTable.fadeInTime or 0) > 0 and canHighlight then
					local transparencyTween = tweenService:Create(transparencyValue, TweenInfo.new(configTable.fadeInTime or 0, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						Value = configTable.transparency or (OldHighlight.Enabled and 0.1) or 0.4
					})
					transparencyTween:Play()
					highlightMaid:GiveTask(function()
						transparencyTween:Cancel()
					end)
					transparencyTween.Completed:Wait()
				end
				if configTable.lastsForever then
					return
				end
				if configTable.duration and canHighlight then
					task.wait(configTable.duration)
				end
				if configTable.fadeOutTime and canHighlight then
					local fadeOutTween = tweenService:Create(transparencyValue, TweenInfo.new(configTable.fadeOutTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						Value = 1
					})
					fadeOutTween:Play()
					highlightMaid:GiveTask(function()
						fadeOutTween:Cancel()
					end)
					fadeOutTween.Completed:Wait()
				elseif not configTable.fadeOutTime and canHighlight then
					transparencyValue.Value = 1
				end
				highlightMaid:DoCleaning()
			end)
			return highlightMaid
		end
		table.insert(vapeConnections, vapeEvents.EntityDamageEvent.Event:Connect(function(damageTable)
			if damageTable.entityInstance ~= lplr.Character then
				highlightNew(damageTable.entityInstance, { duration = 0.13 })
			end
		end))

		local shell = {}
		local indicatorConstants = debug.getupvalue(bedwars.DamageIndicator, 2)
		indicatorConstants = type(indicatorConstants) == "table" and indicatorConstants or {
			velX = 5,
			velY = 9,
			velZ = 5,
			gravityDamage = 0.9,
			gravityHeal = 0.98,
			textSize = 28,
			blowUpCompleteDuration = 0.05,
			blowUpDuration = 0.125,
			blowUpSize = 76,
			anchoredDuration = 0.4,
			strokeThickness = 1.5,
			baseColor = Color3.fromRGB(255, 81, 68)
		}
		local function unanchor(part)
			part.Anchored = false
		end
		local function spawnDamageIndicatorNew(Self, fromPos, damage, damageTable)
			damageTable = damageTable or shell
			local canshow = damageTable.infiniteRange or (gameCamera.CFrame.Position - fromPos).Magnitude <= 200
			damage = math.ceil(damage)
			local indicator = Instance.new("Part")
			indicator.Name = "DamageIndicatorPart"
			indicator.Size = Vector3.new(1, 1, 1)
			indicator.Transparency = 1
			indicator.CanCollide = false
			indicator.CanQuery = false
			indicator.CFrame = CFrame.new(fromPos)
			indicator.Anchored = true
			task.delay(indicatorConstants.anchoredDuration, unanchor, indicator)
			local bodyvelo = Instance.new("BodyForce")
			local gravity
			if damage < 0 then
				gravity = indicatorConstants.gravityHeal
			else
				gravity = indicatorConstants.gravityDamage
			end
			bodyvelo.Force = Vector3.new(0, indicator:GetMass() * workspace.Gravity * gravity, 0)
			bodyvelo.Parent = indicator
			indicator.Velocity = Vector3.new(math.random(-50, 50) / 100 * indicatorConstants.velX, 0, math.random(-50, 50) / 100 * indicatorConstants.velZ)
			local textGui = Instance.new("BillboardGui")
			local size = 2.1 + 0.7 * (math.min(damage, 100) / 100)
			textGui.Size = UDim2.new(size * 2.1, 0, size, 0)
			textGui.AlwaysOnTop = true
			textGui.MaxDistance = damageTable.infiniteRange and math.huge or 100
			local frame = bedwars.make("Frame", {
				Size = UDim2.fromScale(1, 1), 
				Position = UDim2.fromScale(0.5, 0.5), 
				AnchorPoint = Vector2.new(0.5, 0.5), 
				BackgroundTransparency = 1, 
				Parent = textGui
			})
			local icon
			if damageTable.image and damageTable.image ~= "" then
				icon = bedwars.make("ImageLabel", {
					BackgroundTransparency = 1,
					Image = damageTable.image,
					ImageColor3 = damageTable.imageColor,
					Position = UDim2.fromScale(0.25, 0.5),
					AnchorPoint = Vector2.new(0, 0.5),
					Size = UDim2.fromScale(0.25, 1),
					Parent = frame,
				})
				bedwars.make("UIAspectRatioConstraint", {
					DominantAxis = Enum.DominantAxis.Width,
					AspectRatio = 1,
					Parent = icon
				})
			end
			local damageText = Instance.new("TextLabel")
			damageText.Size = UDim2.new(0.5, 0, 1, 0)
			damageText.BackgroundTransparency = 1
			damageText.BorderSizePixel = 0
			if GuiLibrary.ObjectsThatCanBeSaved.GameThemeOptionsButton.Api.Enabled then
				damageText.Font = Enum.Font.LuckiestGuy
			else
				damageText.Font = Enum.Font.GothamBlack
			end
			damageText.Position = UDim2.fromScale(0.5, 0.5)
			damageText.AnchorPoint = Vector2.new(0, 0.5)
			damageText.TextSize = 25
			damageText.TextXAlignment = Enum.TextXAlignment.Left
			if DamageIndicators.Enabled and DamageIndicatorsText.Enabled then
				if DamageIndicatorsCustom.Enabled and #DamageIndicatorsList.ObjectList > 0 then
					damageText.Text = DamageIndicatorsList.ObjectList[math.random(1, #DamageIndicatorsList.ObjectList)]
				else
					damageText.Text = backupText[math.random(1, #backupText)]
				end
			else
				damageText.Text = tostring(damage)
			end
			local newcolor
			if damageTable.color then
				if typeof(damageTable.color) == "Color3" then
					newcolor = damageTable.color
				else
					newcolor = bedwars.ColorUtil.WHITE
				end
			end
			damageText.TextColor3 = newcolor or indicatorConstants.baseColor
			if damageTable.color and typeof(damageTable.color) == "ColorSequence" then
				bedwars.make("UIGradient", {
					Color = damageTable.color, 
					Rotation = damageTable.gradientRotation, 
					Parent = damageText
				})
			end
			local uiStroke = bedwars.make("UIStroke", {
				Parent = damageText, 
				Thickness = indicatorConstants.strokeThickness, 
				Color = Color3.fromRGB(0, 0, 0)
			})
			if damageTable.heal then
				damageText.Text = "+" .. tostring(damage)
				damageText.TextColor3 = bedwars.theme.mcGreen
			else
				if damageTable.shieldHit then
					damageText.TextColor3 = bedwars.healthBarShieldColor
				end
			end
			if damageTable.damageType == 8 then -- poison damage
				damageText.TextColor3 = bedwars.ColorUtil.hexColor(5025629)
			end
			damageText.Parent = frame
			textGui.Parent = indicator
			indicator.Parent = workspace
			if DamageIndicators.Enabled and DamageIndicatorsColor.Enabled then
				damageText.TextColor3 = Color3.fromHSV(DamageIndicatorsColorSlider.Hue, DamageIndicatorsColorSlider.Sat, DamageIndicatorsColorSlider.Value)
				task.spawn(function()
					repeat
						damageText.TextColor3 = Color3.fromHSV(DamageIndicatorsColorSlider.Hue, DamageIndicatorsColorSlider.Sat, DamageIndicatorsColorSlider.Value)
						task.wait()
					until not indicator.Parent or not (DamageIndicators.Enabled and DamageIndicatorsColor.Enabled)
				end)
			end
			task.spawn(function()
				local oldTextSize = damageText.TextSize
				local oldSize = frame.Size
				local blowupRatio = indicatorConstants.blowUpSize / oldTextSize
				local mainTween = bedwars.TweenDefault(indicatorConstants.blowUpDuration, bedwars.EasingFunctions.Linear, function(easing)
					damageText.TextSize = oldTextSize * (1 - easing) + easing * indicatorConstants.blowUpSize
					local scalefactor = 1 - easing
					local oldScale = UDim2.new(oldSize.X.Scale * scalefactor, oldSize.X.Offset * scalefactor, oldSize.Y.Scale * scalefactor, oldSize.Y.Offset * scalefactor)
					local blowupScale = easing * blowupRatio
					frame.Size = oldScale + UDim2.new(oldSize.X.Scale * blowupScale, oldSize.X.Offset * blowupScale, oldSize.Y.Scale * blowupScale, oldSize.Y.Offset * blowupScale)
				end, 0, 1)
				mainTween:Play()
				mainTween:Wait()
				oldTextSize = damageText.TextSize
				oldSize = frame.Size
				local textRatio = indicatorConstants.textSize / oldTextSize
				bedwars.TweenDefault(indicatorConstants.blowUpCompleteDuration, bedwars.EasingFunctions.Linear, function(easing)
					damageText.TextSize = oldTextSize * (1 - easing) + easing * indicatorConstants.textSize
					local scalefactor = 1 - easing
					local oldScale = UDim2.new(oldSize.X.Scale * scalefactor, oldSize.X.Offset * scalefactor, oldSize.Y.Scale * scalefactor, oldSize.Y.Offset * scalefactor)
					local completionScale = easing * textRatio
					frame.Size = oldScale + UDim2.new(oldSize.X.Scale * completionScale, oldSize.X.Offset * completionScale, oldSize.Y.Scale * completionScale, oldSize.Y.Offset * completionScale)
				end, 0, 1):Play()
			end)
			local strokeTween = tweenService:Create(uiStroke, TweenInfo.new((GuiLibrary.ObjectsThatCanBeSaved.GameThemeOptionsButton.Api.Enabled and 0.3 or 0.2), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Transparency = 1
			})
			task.spawn(function()
				indicator.Velocity = Vector3.new((math.random(-50, 50) / 100) * indicatorConstants.velX, (math.random(50, 60) / 100) * indicatorConstants.velY, (math.random(-50, 50) / 100) * indicatorConstants.velZ)
				if not (DamageIndicators.Enabled and (DamageIndicatorsNoFade.Enabled or DamageIndicatorsColor.Enabled)) then
					local textcompare = damageText.TextColor3
					if textcompare ~= Color3.fromRGB(85, 255, 85) then
						local newtween = tweenService:Create(damageText, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
							TextColor3 = (textcompare == Color3.fromRGB(76, 175, 93) and Color3.new(0, 0, 0) or Color3.new(1, 1, 1))
						})
						task.wait(0.15)
						newtween:Play()
					end
				end
			end)
			bedwars.RuntimeLib.Promise.delay(indicatorConstants.anchoredDuration + (GuiLibrary.ObjectsThatCanBeSaved.GameThemeOptionsButton.Api.Enabled and 0.5 or 0.3)):andThen(function()
				bedwars.TweenDefault(0.2, bedwars.EasingFunctions.OutQuad, function(easing)
					damageText.TextTransparency = easing
					if icon then
						icon.ImageTransparency = easing
					end
				end, 0, 1)
				strokeTween:Play()
			end)
			game:GetService("Debris"):AddItem(indicator, 1.5)
		end
		bedwars.DamageIndicatorController.spawnDamageIndicator = spawnDamageIndicatorNew
	end)
end
