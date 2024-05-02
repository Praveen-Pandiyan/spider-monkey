import React, { useCallback, useEffect, useMemo, useState } from "react";
import ReactFlow, {
  MiniMap,
  Controls,
  Background,
  useNodesState,
  useEdgesState,
  addEdge,
  useOnSelectionChange,
  getOutgoers,
  useReactFlow,
  ReactFlowProvider,
} from "reactflow";
import { initialNodes, initialEdges, saveFlow } from "./provider";
import "reactflow/dist/style.css";
import "./App.css";
// custome nodes
import ConditionNode from "./components/nodes/condition";
function Flow() {
  const [showWidgets, setShowWidgets] = useState(false);
  const [nodes, setNodes, onNodesChange] = useNodesState(initialNodes());
  const [edges, setEdges, onEdgesChange] = useEdgesState(initialEdges());
  const { getNodes, getEdges } = useReactFlow();
  // custom widgets : begin
  const customNodes = useMemo(() => ({ condition: ConditionNode }), []);
  // custom widgets : ends

  useEffect(()=>{
    console.log("on user effect ");
    window.addEventListener("message", (event) => {
      console.log(event);
    }, false);
    window.addEventListener("addNode", (event) => {
      console.log(event);
      setNodes([...getNodes(),event.detail]);
    }, false);
    window.addEventListener("addEdge", (event) => {
      console.log(event);
      setEdges([...getEdges(),event.detail]);
    }, false);
  },[])
  useOnSelectionChange({
    onChange: ({ nodes, edges }) => {
      console.log(nodes);
      window.addEventListener("flutterInAppWebViewPlatformReady", function(event) {
        window.flutter_inappwebview.callHandler('onSelect', nodes);
       });
   
    },
  });
  const isValidConnection = useCallback(
    (connection) => {
      const nodes = getNodes();
      const edges = getEdges();
      const target = nodes.find((node) => node.id === connection.target);
      const hasCycle = (node, visited = new Set()) => {
        if (visited.has(node.id)) return false;
        visited.add(node.id);
        for (const outgoer of getOutgoers(node, nodes, edges)) {
          if (outgoer.id === connection.source) return true;
          if (hasCycle(outgoer, visited)) return true;
        }
      };

      if (target.id === connection.source) return false;
      return !hasCycle(target);
    },
    [getNodes, getEdges]
  );

  const onConnect = useCallback(
    (params) => setEdges((eds) => addEdge(params, eds)),
    [setEdges]
  );
  const onSave = () => {
    saveFlow(nodes, edges);
  };
  return (
    <div style={{ width: "100vw", height: "100vh" }}>
      <ReactFlow
        nodes={nodes}
        edges={edges}
        nodeTypes={customNodes}
        onNodesChange={onNodesChange}
        onEdgesChange={onEdgesChange}
        selectionOnDrag
        isValidConnection={isValidConnection}
        onConnect={onConnect}
      >
        <Controls  />
        <MiniMap />
        <Background variant="dots" gap={12} size={1} color="#fff" />
      </ReactFlow>
    </div>
  );
}

export default function App() {
  return (
    <ReactFlowProvider>
      <Flow />
    </ReactFlowProvider>
  );
}
