//TODO
//IMPLEMENTFORAI
#define ROW 5
#define COL 5

typedef struct {
    int x, y;
} Point;

typedef struct {
    int f, g, h;
    Point parent;
    int walkable;
} Node;

Node grid[ROW][COL];

int isValid(int row, int col) {
    return (row >= 0) && (row < ROW) && (col >= 0) && (col < COL);
}

int isDestination(Point p, Point dest) {
    return (p.x == dest.x) && (p.y == dest.y);
}

int calculateH(Point p, Point dest) {
    return abs(dest.x - p.x) + abs(dest.y - p.y); // Manhattan distance
}

void printPath(Node grid[ROW][COL], Point dest) {
    Point p = dest;
    printf("Path: ");
    while (grid[p.x][p.y].parent.x != -1 && grid[p.x][p.y].parent.y != -1) {
        printf("(%d,%d) <- ", p.x, p.y);
        p = grid[p.x][p.y].parent;
    }
    printf("(%d,%d)\n", p.x, p.y);
}

void aStar(Point start, Point dest) {
    if (!grid[start.x][start.y].walkable || !grid[dest.x][dest.y].walkable) {
        printf("Start or destination is blocked.\n");
        return;
    }

    int closedList[ROW][COL] = {0};
    grid[start.x][start.y].f = 0;
    grid[start.x][start.y].g = 0;
    grid[start.x][start.y].h = 0;
    grid[start.x][start.y].parent = (Point){-1, -1};

    Point openList[ROW * COL];
    int openCount = 0;

    openList[openCount++] = start;

    while (openCount > 0) {
        int lowestIndex = 0;
        for (int i = 1; i < openCount; i++) {
            Point p = openList[i];
            Point lp = openList[lowestIndex];
            if (grid[p.x][p.y].f < grid[lp.x][lp.y].f) {
                lowestIndex = i;
            }
        }

        Point current = openList[lowestIndex];

        if (isDestination(current, dest)) {
            printPath(grid, dest);
            return;
        }

        openCount--;
        for (int i = lowestIndex; i < openCount; i++) {
            openList[i] = openList[i + 1];
        }

        closedList[current.x][current.y] = 1;

        Point directions[] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        for (int i = 0; i < 4; i++) {
            Point neighbor = {current.x + directions[i].x, current.y + directions[i].y};

            if (isValid(neighbor.x, neighbor.y) && grid[neighbor.x][neighbor.y].walkable && !closedList[neighbor.x][neighbor.y]) {
                int tentativeG = grid[current.x][current.y].g + 1;

                if (tentativeG < grid[neighbor.x][neighbor.y].g || grid[neighbor.x][neighbor.y].g == INT_MAX) {
                    openList[openCount++] = neighbor;

                    grid[neighbor.x][neighbor.y].g = tentativeG;
                    grid[neighbor.x][neighbor.y].h = calculateH(neighbor, dest);
                    grid[neighbor.x][neighbor.y].f = grid[neighbor.x][neighbor.y].g + grid[neighbor.x][neighbor.y].h;
                    grid[neighbor.x][neighbor.y].parent = current;
                }
            }
        }
    }

    printf("Path not found.\n");
}

int main() {
    Point start = {0, 0};
    Point dest = {4, 4};

    // Initialize grid
    for (int i = 0; i < ROW; i++) {
        for (int j = 0; j < COL; j++) {
            grid[i][j].walkable = 1;  // All cells walkable
            grid[i][j].g = INT_MAX;
            grid[i][j].h = INT_MAX;
            grid[i][j].f = INT_MAX;
        }
    }

    // Add some obstacles
    grid[1][1].walkable = 0;
    grid[1][2].walkable = 0;
    grid[1][3].walkable = 0;

    aStar(start, dest);

    return 0;
}
