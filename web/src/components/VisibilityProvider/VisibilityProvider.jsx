import { useEffect, useState } from "react";

import "./VisibilityProvider.css";
import App from "../../pages/App/App";

const VisibilityProvider = () => {
    const [visible, setVisible] = useState(false);

    useEffect(() => {
        window.addEventListener("message", (event) => {
        if (event.data.type === "show") {
            setVisible(!visible);
        }
        });
    }, [visible])

    return (
        <>
            {visible ? <App/> : null}
        </>
    );
};

export default VisibilityProvider;