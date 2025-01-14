#define TABLE_SIZE 100

// Node structure for a linked list (to handle collisions)
class Node {
    char key[50];
    char value[50];
    class Node *next;
} headNode;

// Hash table structure
Node *hash_table[TABLE_SIZE];

// Hash function
U64 hash(U8 *key) {
    U64 hash = 0;
    while (*key) {
        hash = (hash * 31) + *key++;
    }
    return hash % TABLE_SIZE;
}

// Insert a key-value pair
void insert(const char *key, const char *value) {
    unsigned int index = hash(key);
    Node *new_node = (Node *)malloc(sizeof(Node));
    strcpy(new_node->key, key);
    strcpy(new_node->value, value);
    new_node->next = hash_table[index];
    hash_table[index] = new_node;
}

// Retrieve a value by key
const char *search(const char *key) {
    unsigned int index = hash(key);
    Node *current = hash_table[index];
    while (current) {
        if (strcmp(current->key, key) == 0) {
            return current->value;
        }
        current = current->next;
    }
    return NULL; // Key not found
}

// Free all nodes in the hash table
void free_table() {
    for (int i = 0; i < TABLE_SIZE; i++) {
        Node *current = hash_table[i];
        while (current) {
            Node *temp = current;
            current = current->next;
            free(temp);
        }
        hash_table[i] = NULL;
    }
}

int main() {
    insert("name", "Bob");
    insert("age", "30");
    insert("city", "Atlantis");

    const char *value = search("city");
    if (value) {
        printf("Value for 'city': %s\n", value);
    } else {
        printf("Key not found\n");
    }

    free_table();
    return 0;
}
