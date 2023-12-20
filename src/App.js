import * as React from "react";
import { useState } from 'react';
import './App.css';
//import MainMint from './MainMint'
import NavBar from './NavBar'


function App() {
  const [accounts, setAccounts] = useState([]);

  return (<div className='App'>
    <NavBar accounts={accounts} setAccounts={setAccounts} />
    
  </div>)
  return (
    <div className="App">
      <div>Hello</div>
    </div>
  );
}

export default App;
