import react from "react";

const NavBar = ({ accounts, setAccounts }) => {

    const isConected = Boolean(accounts[0]);

    async function connectionAccount () {
        if(windows.ethereum) {
            const accounts = await window.ethereum.request({
                method: "eth_requestAccounts",
            })
            setAccounts(accounts);
        }
    }
    return (
        <div>
            <div>Hotel 1</div>
            <div>Hotel 2</div>
            <div>Hotel 3</div>


            <div>About</div>
            <div>Book</div>

            {isConnected ? (
                <p>Connected</p>
            ) : ( 
                <button onClick={connectAccount}>Connect</button>
            )}
        </div>
    )
}

export default NavBar;