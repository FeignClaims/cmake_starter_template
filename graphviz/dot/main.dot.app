digraph "app" {
node [ fontsize = "12" ]
    "node0" [ label = "app", shape = egg ];
    "node1" [ label = "app_library", shape = octagon ];
    "node0" -> "node1" [ style = dotted ] // app -> app_library
    "node2" [ label = "project_options", shape = pentagon ];
    "node1" -> "node2"  // app_library -> project_options
    "node3" [ label = "project_warnings", shape = pentagon ];
    "node1" -> "node3"  // app_library -> project_warnings
    "node4" [ label = "fmt::fmt", shape = pentagon ];
    "node0" -> "node4" [ style = dotted ] // app -> fmt::fmt
}
