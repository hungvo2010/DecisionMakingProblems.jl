struct Travelers end

# number of agents in Travelers is 2
n_agents(simpleGame::Travelers) = 2

# set of actions of specific agent in Travelers
ordered_actions(simpleGame::Travelers, i::Int) = 2:100
# set of actions of all agents in Travelers: [2:100] x [2:100]
ordered_joint_actions(simpleGame::Travelers) = vec(collect(Iterators.product([ordered_actions(simpleGame, i) for i in 1:n_agents(simpleGame)]...)))

# number of element of set of actions of all agents
n_joint_actions(simpleGame::Travelers) = length(ordered_joint_actions(simpleGame))
# number of element of set of actions of specific agent
n_actions(simpleGame::Travelers, i::Int) = length(ordered_actions(simpleGame, i))

# function to calculate how much money Agent "i" is rewarded
function reward(simpleGame::Travelers, i::Int, a)
    if i == 1
        noti = 2
    else
        noti = 1
    end
    if a[i] == a[noti]
        r = a[i]
    elseif a[i] < a[noti]
        r = a[i] + 2
    else
        r = a[noti] - 1
    end
    return r
end

# function to return how much money all agents are rewarded
# [a + 2, a - 2]
function joint_reward(simpleGame::Travelers, a)
    return [reward(simpleGame, i, a) for i in 1:n_agents(simpleGame)]
end

# recursive function
function SimpleGame(simpleGame::Travelers)
    return SimpleGame(
        0.9, # discount factor
        vec(collect(1:n_agents(simpleGame))), # vector of all agents [1, 2]
        [ordered_actions(simpleGame, i) for i in 1:n_agents(simpleGame)], # [2:100 2:100] # joint action space
        (a) -> joint_reward(simpleGame, a) # an arrow function
    )
end
