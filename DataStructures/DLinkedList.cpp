#include <cstdlib>
#include <vector>
#include <iostream>

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
            // scope for some nasty pointer bugs if not initialized as null and used with dynamic memory allocation
            next = prev = NULL;
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
          // Check if first element
          if(current -> prev == NULL)
          {
            // take care if its also the last
            if(first -> next != NULL)
            {
              first -> next -> prev = NULL;
              first = first -> next;
            }
            else
            {
              first = NULL;
              last = NULL;
            }
          }
          // Check if last element
          else if(current -> next == NULL)
          {
            last = last -> prev;
            last -> next = NULL;
          }
          // somewhere in the middle
          else
          {
            current -> prev -> next = current -> next;
            current -> next -> prev = current -> prev;
          }
          // Ensure good housekeeping
          {
            current -> prev = current -> next = NULL;
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

      if(size == 0) return v;
      Node<T> * current = first;
      for(;current != NULL;)
      {
        v.push_back(current -> content);
        current = current -> next;
      }

      return v;
    }
};
