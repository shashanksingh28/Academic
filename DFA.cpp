#include <vector>

using namespace std;
/*
* Class to represent a deterministic finite state machine.
* Each DFA consists of states, alphabets,
*/
class DFA
{
  int noOfStates;
  int noOfAlphabets;
  int startIndex;
  int** delta;
  bool* acceptStates;

  public:
    DFA(int numberOfStates, int numberOfAlphabets, int** transitions, int startState, bool* finalStates)
    {
      noOfStates = numberOfStates;
      noOfAlphabets = numberOfAlphabets;
      startIndex = startState;
      acceptStates = new bool[noOfStates];
      delta = new int*[noOfStates];

      for(int i=0; i < noOfStates; i++)
      {
        delta[i] = new int[noOfAlphabets];
        acceptStates[i] = finalStates;
        for(int j=0; j < noOfAlphabets; j++)
        {
          // for simplicity, consider alphabets to be indexed as 0, 1, 2 etc
          delta[i][j] = transitions[i][j];
        }
      }
    }
};

int main()
{
  int states = 3;
  int alphabets = 2;
  int startState = 0;
  bool finalStates[] = {false, true, false};
  int** delta= new int*[3];
  delta[0] = new int[2];
  delta[1]=new int[2];
  delta[2]=new int[2];
  delta[0][0]= 0;
  delta[0][1]=1;
  delta[1][0]=1;
  delta[1][1]=1;
  delta[2][0]=1;
  delta[2][1]=0;
  DFA dfa1 (states,alphabets,delta,startState,finalStates);
}
