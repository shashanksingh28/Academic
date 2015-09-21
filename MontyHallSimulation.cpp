#include <cstdlib>
#include <iostream>

using namespace std;

int main()
{
  srand(time(0));
  int actual_gift = 0;
  int your_choice = 0;

  int nonChangehits = 0;
  int changeHits = 0;

for(int j = 0; j <1000000 ; j++)
{
  // Let gift be in any random door from 1 to 3
  actual_gift = rand()%3;

  // Let the door you choose be another random door from 1 to 3
  your_choice = rand()%3;

  /* Now Monty knows the correct door and he always opens one door without the gift...
  He then asks you if you would still like to change your choice of door to the other non-opened door.
  You can either choose to stick with the same or switch.
  It might seem intuitive that you stand an equal chance now that there are two doors left.

  What we do in the program is increment counters when not switching wins or switching wins,
  and we do this experiment a million or more times.
  */

  if(actual_gift == your_choice) nonChangehits++;
  else changeHits++;

}
  cout <<"Not changing wins :"<< nonChangehits << endl <<"Changing wins : " << changeHits<< endl;
}
