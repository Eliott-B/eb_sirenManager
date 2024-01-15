import React from "react";
import ReactDOM from "react-dom/client";

// PAGES
import App from "./pages/App/App";

// STYLES
import "./global.css";

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
);
