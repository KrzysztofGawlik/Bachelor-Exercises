/*
    GAWLIK KRZYSZTOF
    Indeks: 147762
*/
#include <iostream>
#include <stdlib.h>
#include <ctime>
using namespace std;

int rollDice();
int checkState(int round, int pts, int roll);
void pause(const char* msg);

class Game {
    public:
        int money;
        int pts;
        int round;
        int winVal;
        int loseVal;
        int state;
        int roll;

    void setDefaultStats() {
        money = 100;
        winVal = 10;
        loseVal = 15;
        round = 0;
        pts = 0;
        state = 0; // 0:neutral, 1:win, 2:lose
    }

    void startGame() {
    do {
        state = 0;
        round += 1;
        printf("THROW %d\n", round);
        roll = rollDice();
        if(pts == 0) {
            pts = roll;
            printf("Your points set to: %d\n", pts);
        }
        state = checkState(round, pts, roll);
        switch(state) {
            case 0 : {
                pause("No luck - roll again . . .");
            } break;
            case 1 : {
                money += winVal;
                printf("You WON! Congrats! You've got %d PLN!", money);
                pause("");
            } break;
            case 2 : {
                money -= loseVal;
                printf("You LOSE :( Better luck next time! You've got %d PLN.", money);
                pause("");
            } break;
        }
    } while(state == 0);

    }
};

int main() {

    int userInput;

    srand((unsigned) time(0));
    Game Player;
    Player.setDefaultStats();

    printf("\nWelcome to GAME OF DICE!\n\n");
    printf("You got two dices with 1 to 6 points each.\n");
    printf("If you roll 7 or 11 on your first shot - you win, you lose when its 2, 3 or 12.\n");
    printf("If you roll other number it becomes your points. Game continues until you\n");
    printf("get number of your points. But be aware of 7! 7 ends the game.\n");
    printf("Starter balance: %d PLN (every win: +%d PLN, every lose: -%d PLN)\n", Player.money, Player.winVal, Player.loseVal);
    pause("Press Enter to start the game . . .");

    Player.startGame();

    while(true) {
        printf("---- SELECT OPTION ----");
        printf("\n1. Resume game\n2. New game\n0. Quit game\n");
        cin >> userInput;
        switch(userInput) {
            case 1: {
                Player.round = 0;
                Player.pts = 0;
                Player.startGame(); break;
            } break;
            case 2: {
                printf("\n*** NEW GAME ***\n");
                Player.setDefaultStats();
                Player.startGame();
            } break;
            case 0: return 0;
        }
    }

    return 0;
}

int rollDice() {
    int dice1 = rand() % 6 + 1;
    int dice2 = rand() % 6 + 1;
    printf("You rolled %d and %d... (%d)\n", dice1, dice2, dice1+dice2);
    return dice1 + dice2;
}

int checkState(int round, int pts, int roll) {
    if(round == 1) {
        if(pts == 7 || pts == 11) return 1;
        if(pts == 2 || pts == 3 || pts == 12) return 2;
        return 0;
    } else {
        if(roll == 7) return 2;
        if(roll == pts) return 1;
        return 0;
    }
}

void pause(const char* msg) {
    cout << msg << endl;
    cin.sync();
    cin.get();
}