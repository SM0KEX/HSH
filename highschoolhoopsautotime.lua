local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ActionsRemote = ReplicatedStorage
    :WaitForChild('Lib')
    :WaitForChild('EventsPlayer')
    :WaitForChild('Actions')
local UserInputService = game:GetService('UserInputService')

local shooting = false

local function standingShot()
    -- StartMeter
    local argsStart = {
        {
            Shift = false,
            ShotType = 'Normal',
            Action = 'StartMeter',
            ShotName = 'Reg',
        },
    }
    ActionsRemote:FireServer(unpack(argsStart))

    wait(0.6) -- Adjust timing for meter

    -- StopMeter
    local argsStop = {
        {
            Action = 'StopMeter',
            PumpFake = false,
        },
    }
    ActionsRemote:FireServer(unpack(argsStop))

    wait(0.3) -- Adjust timing before shooting

    -- ShootBall
    local argsShoot = {
        {
            Action = 'ShootBall',
            ClientTime = 0,
        },
    }
    ActionsRemote:FireServer(unpack(argsShoot))
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end
    if input.KeyCode == Enum.KeyCode.E and not shooting then
        shooting = true
        standingShot()
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end
    if input.KeyCode == Enum.KeyCode.E and shooting then
        shooting = false
    end
end)
