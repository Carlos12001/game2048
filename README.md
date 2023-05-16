# 2048 for SystemVerilog

This is a SystemVerilog implementation of the game 2048.

```graphviz
digraph finite_state_machine {
    size="20,20";
    node [shape = doublecircle, fontname=Helvetica, fixedsize=true, width=1.5]; "START" "GAME_OVER";
node [shape = circle, fontname=Helvetica, fixedsize=true, width=1.5];


    subgraph cluster_0 {
        label = "Estados iniciales";
        color = blue;
        "START" "1st RANDOM" "TRANS 2nd" "2nd RANDOM";
    }
    
    subgraph cluster_1 {
    label = "Estados intermedios";
    color = green;
    "IDLE" "MOVE_MERGE" "TRANS NEW" "NEW_TILE";
    }
    
    subgraph cluster_2 {
    label = "Estados finales";
    color = red;
    "CHECK_WIN" "CHECK_LOSE" "GAME_OVER";
    }



    "START" -> "1st RANDOM" [ label = "Initialize" ];
    "1st RANDOM" -> "TRANS 2nd" [ label = "First tile placed" ];
    "TRANS 2nd" -> "2nd RANDOM" [ label = "Transition" ];
    "2nd RANDOM" -> "IDLE" [ label = "Second tile placed" ];
    "IDLE" -> "MOVE_MERGE" [ label = "Player makes a move" ];
    "MOVE_MERGE" -> "TRANS NEW" [ label = "Move and merge done" ];
    "TRANS NEW" -> "NEW_TILE" [ label = "Check for new tile" ];
    "NEW_TILE" -> "CHECK_WIN" [ label = "New tile placed" ];
    "CHECK_WIN" -> "CHECK_LOSE" [ label = "Game not won" ];
    "CHECK_WIN" -> "GAME_OVER" [ label = "Game won" ];
    "CHECK_LOSE" -> "IDLE" [ label = "Game not lost" ];
    "CHECK_LOSE" -> "GAME_OVER" [ label = "Game lost" ];
}
```


```graphviz
digraph finite_state_machine {
    size="20,20";
    node [shape = doublecircle, fontname=Helvetica, fixedsize=true, width=1.5]; "IDLE";
    node [shape = circle, fontname=Helvetica, fixedsize=true, width=1.5];

    "IDLE" -> "SEARCH" [ label = "Start" ];
    "SEARCH" -> "FINISH" [ label = "Empty cell found" ];
    "SEARCH" -> "SEARCH" [ label = "Empty cell not found" ];
    "FINISH" -> "IDLE" [ label = "Done" ];
}

```
