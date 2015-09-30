#include <cstdlib>
#include <vector>

using namespace std;

template <class T> class DLinkedList
{
  private:
    template <class X> class Node
    {
        public:
          Node<T>* next;
          Node<T>* prev;

          T content;

          Node(T data)
          {
            this -> content = data;
          }
    };

    Node<T>* first;
    Node<T>* last;

  public:

    int size;

    DLinkedList()
    {
        size = 0;
        first = last = NULL;
    }

    void add(T content)
    {
      if(first == NULL)
      {
        first = new Node<T>(content);
        last = first;
      }
      else
      {
        last -> next = new Node<T>(content);
        last -> next -> prev = last;
        last = last -> next;
      }
      size++;
    }

    int getIndex(T value)
    {
      if(size == 0) return -1;
      int i=0;

      Node<T>* current = first;
      while(current != NULL)
      {
        if(current -> content == value) return i;
        i++;
        current = current -> next;
      }

      return -1;
    }

    // Remove element if present and return index after removal. If not present, return -1
    int remove(T value)
    {
      if(size == 0) return -1;
      int i=0;

      Node<T>* current = first;
      while(current != NULL)
      {
        if(current -> content == value)
        {
          if(current -> prev == NULL)
          {
            // must be first element
            first = first -> next;
            first -> prev = NULL;
            // take care if first == last
            if(current == last) last = first;
            delete current;
          }
          else if(current -> next == NULL)
          {
            // must be last element
            last = last -> prev;
            last -> next = NULL;
          }
          else
          {
            // somewhere in the middle
            current -> prev -> next = current -> next;
            current -> next -> prev = current -> prev;
            delete current;
          }

          size--;
          return i;
        }

        i++;
        current = current -> next;
      }

      return -1;
    }

    // Note that this is a new list and not a projection
    vector<T> getAll()
    {
      vector<T> v;
      Node<T> * current = first;
      for(int i = 0; current != NULL; i++, current = current -> next)
      {
        v.push_back(current -> content);
      }

      return v;
    }
};
