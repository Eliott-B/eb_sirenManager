import React from "react";
import ReactDOM from "react-dom/client";

// COMPONENTS
import VisibilityProvider from "./components/VisibilityProvider/VisibilityProvider";

// STYLES
import "./global.css";

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <VisibilityProvider/>
  </React.StrictMode>,
);
