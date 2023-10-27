import logo from "./logo.svg";
import "./App.css";

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <h1>Welcome</h1>
        <p>URL: {window.location.hostname}</p>
      </header>
    </div>
  );
}

export default App;
