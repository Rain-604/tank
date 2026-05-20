#include <iostream>
#include <string>
#include <vector>
#include <cstdlib>

#include "../../common/map.h"

namespace {

int g_failures = 0;

void expect_true(bool condition, const std::string& name) {
    if (!condition) {
        std::cerr << "[FAIL] " << name << '\n';
        ++g_failures;
    } else {
        std::cout << "[PASS] " << name << '\n';
    }
}

int count_walkable(const Map& map) {
    int total = 0;
    for (int x = 0; x < 40; ++x) {
        for (int z = 0; z < 40; ++z) {
            if (map.grid[x][z] == 1) {
                ++total;
            }
        }
    }
    return total;
}

void test_level1_holes() {
    Map map;
    map.loadLevel(1);

    expect_true(map.grid[11][11] == 0, "level1: hole exists outside spawn override zone");
    expect_true(map.grid[12][12] == 0, "level1: 2x2 hole pattern exists");
    expect_true(map.grid[0][0] == 1, "level1: spawn corner is walkable");
}

void test_level2_grid_pattern() {
    Map map;
    map.loadLevel(2);

    expect_true(map.grid[0][0] == 1, "level2: (0,0) is road");
    expect_true(map.grid[1][2] == 1, "level2: row 1 is road");
    expect_true(map.grid[2][1] == 1, "level2: column 1 is road");
    expect_true(map.grid[10][10] == 0, "level2: (10,10) is block gap");
}

void test_spawn_zones_all_levels() {
    Map map;
    for (int level = 1; level <= 4; ++level) {
        if (level == 4) {
            std::srand(12345);
        }
        map.loadLevel(level);

        bool spawnOk = true;
        for (int x = 0; x < 6; ++x) {
            for (int z = 0; z < 6; ++z) {
                if (map.grid[x][z] != 1) {
                    spawnOk = false;
                }
            }
        }

        bool enemyOk = true;
        for (int x = 34; x < 40; ++x) {
            for (int z = 34; z < 40; ++z) {
                if (map.grid[x][z] != 1) {
                    enemyOk = false;
                }
            }
        }

        expect_true(spawnOk, "level" + std::to_string(level) + ": player spawn zone is safe");
        expect_true(enemyOk, "level" + std::to_string(level) + ": enemy spawn zone is safe");
    }
}

void test_cube_positions_match_grid() {
    Map map;
    for (int level = 1; level <= 4; ++level) {
        if (level == 4) {
            std::srand(12345);
        }
        map.loadLevel(level);

        int walkable = count_walkable(map);
        expect_true(static_cast<int>(map.cubePositions.size()) == walkable,
                    "level" + std::to_string(level) + ": cubePositions count equals walkable tiles");

        bool allValid = true;
        for (size_t i = 0; i < map.cubePositions.size(); ++i) {
            const Vec3& p = map.cubePositions[i];
            if ((p.x % 2) != 0 || (p.z % 2) != 0 || p.y != 0) {
                allValid = false;
                break;
            }
            int gx = p.x / 2;
            int gz = p.z / 2;
            if (gx < 0 || gx >= 40 || gz < 0 || gz >= 40 || map.grid[gx][gz] != 1) {
                allValid = false;
                break;
            }
        }

        expect_true(allValid, "level" + std::to_string(level) + ": cubePositions map back to walkable grid cells");
    }
}

} // namespace

int main() {
    test_level1_holes();
    test_level2_grid_pattern();
    test_spawn_zones_all_levels();
    test_cube_positions_match_grid();

    if (g_failures > 0) {
        std::cerr << "\nTests failed: " << g_failures << '\n';
        return 1;
    }

    std::cout << "\nAll tests passed.\n";
    return 0;
}
