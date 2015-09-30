#include <vector>

using namespace std;

// This class is kind of silly because its just a wrap for a vector. But its a restrictive wrapper that is inline with stack api.
template <class T>
class Stack
{
  private:
    vector<T> v;

  public:

    int size()
    {
      return v.size();
    }

    bool empty()
    {
      return (v.size() == 0);
    }

    void push(T object)
    {
      v.push_back(object);
    }

    T pop()
    {
      T obj = v.back();
      v.pop_back();
      return obj;
    }

    T top()
    {
      return v.back();
    }
};
