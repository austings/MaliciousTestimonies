#define FRAMERULE 3
#define FRAMERULE_CAP 30

//ai scripts
#define AI_DEFAULT	1
#define AI_FISHING	10
#define DIALOG_BOX_Y	375

#define A_STAR_MAX_LEN  10






U0 a_star(MapNode *mnStart,MapNode *goal) {
  
 MapNode *openList[A_STAR_MAX_LEN];
 I64 openCount = 0;
/*
    Node* startNode = &grid[start.x][start.y];
    Node* goalNode = &grid[goal.x][goal.y];

    startNode->g = 0;
    startNode->h = heuristic(start, goal);
    startNode->f = startNode->g + startNode->h;
    startNode->parent = start;
    startNode->inOpenList = 1;
    openList[openCount++] = startNode;

    while (openCount > 0) {
        Node* current = get_lowest_f_node(openList, openCount);

        if (is_same_point(current->pos, goal)) {
            printf("Path found:\n");
            reconstruct_path(current);
            return;
        }

        current->inClosedList = 1;

        // Remove from openList
        for (int i = 0; i < openCount; ++i) {
            if (openList[i] == current) {
                for (int j = i; j < openCount - 1; ++j)
                    openList[j] = openList[j + 1];
                --openCount;
                break;
            }
        }

        // Directions: N, S, E, W
        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        for (int i = 0; i < 4; ++i) {
            int nx = current->pos.x + dx[i];
            int ny = current->pos.y + dy[i];

            if (nx < 0 || ny < 0 || nx >= WIDTH || ny >= HEIGHT)
                continue;

            Node* neighbor = &grid[nx][ny];
            if (!neighbor->walkable || neighbor->inClosedList)
                continue;

            int tentative_g = current->g + 1;

            if (!neighbor->inOpenList || tentative_g < neighbor->g) {
                neighbor->g = tentative_g;
                neighbor->h = heuristic(neighbor->pos, goal);
                neighbor->f = neighbor->g + neighbor->h;
                neighbor->parent = current->pos;

                if (!neighbor->inOpenList) {
                    openList[openCount++] = neighbor;
                    neighbor->inOpenList = 1;
                }
            }
        }
    }

    printf("No path found.\n");
*/
}