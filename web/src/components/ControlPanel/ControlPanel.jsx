import { useEffect, useState } from "react";

// STYLES
import "./ControlPanel.css";
import Button from "../Button/Button";

const ControlPanel = () => {
    const [siren, setSiren] = useState(false)
    const [lights, setLights] = useState(false)

    useEffect(() => {
        window.addEventListener("message", (event) => {
        if (event.data.type === "siren") {
            setSiren(event.data.siren);
        }
        if (event.data.type === "lights") {
            setLights(event.data.lights);
        }
        });
    }, [siren, lights])

    return (
        <div className="cp-box">
            <h3 className="cp-title">EB_SIRENMANAGER</h3>
            <div className="cp-buttons">
                <Button title={"lights"} setActive={lights}/>
                <Button title={"siren"} setActive={siren}/>
                <Button title={"horn"} setActive={false}/>
            </div>
        </div>
    );
};

export default ControlPanel;