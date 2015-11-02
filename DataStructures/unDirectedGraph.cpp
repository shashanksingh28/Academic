#include <vector>
#include <set>
#include <string>
#include <iostream>
#include <stack>

using namespace std;

class Node
{
  public:
    char name;
    bool isVisited;

    Node()
    {
      name = 'x';
    }
    Node(char c)
    {
      name = c;
    }
};

ostream& operator<<(ostream& strm, const Node& n)
{
  return strm << n.name;
}

class unDirectedGraph
{
  public:
    vector< set<int> > adj;
    int N;
    Node* nodes;

    unDirectedGraph(int noOfNodes, Node allNodes[])
    {
        N = noOfNodes;
        nodes = allNodes;
        adj.resize(noOfNodes);
    }

    void addEdge(int from, int to)
    {
        if(from < 0 || from >= N) return;
        if(from < 0 || from >= N) return;

        adj[from].insert(to);
        adj[to].insert(from);
    }
};

void DFS(unDirectedGraph g)
{
    bool * visited = new bool[g.N];

    int current = 0;
    stack<int> s;
    s.push(current);
    while(!s.empty())
    {
        current = s.top();
        s.pop();
        if(visited[current]) continue;
        visited[current] = true;
        cout<<g.nodes[current].name<<endl;
        set<int>::iterator it = g.adj[current].begin();
        while(it != g.adj[current].end())
        {
            if(!visited[*it])
            {
                s.push(*it);
            }
            ++it;
        }
    }

}

int main(int argc, char * argv[])
{
    Node a('A');
    Node b('B');
    Node c('C');
    Node d('D');
    Node e('E');
    Node nodes[5];

    nodes[0] = a;
    nodes[1] = b;
    nodes[2] = *(new Node('C'));
    nodes[3] = d;
    nodes[4] = e;

    unDirectedGraph g(5, nodes);

    g.addEdge(0,1);
    g.addEdge(0,4);
    g.addEdge(1,2);
    g.addEdge(1,4);
    g.addEdge(3,4);

    DFS(g);

}
