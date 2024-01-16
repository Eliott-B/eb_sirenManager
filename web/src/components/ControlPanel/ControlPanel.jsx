import { useEffect, useState } from "react";

// STYLES
import "./ControlPanel.css";
import Button from "../Button/Button";

const ControlPanel = () => {
    const [siren, setSiren] = useState(true)
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
            <div className="cp-header">
                <h3 className="cp-title">SirenManager</h3>
            </div>
            <div className="cp-body">
                <Button title={"Hide"}/>
                <Button title={"Lamp"}/>
                <Button title={"Mode"}/>
                <Button title={"Light"} setActive={lights}/>
                <Button title={"Mix"}/>
                <Button title={"Fast"}/>
                <Button title={"Wail"} setActive={siren}/>
                <Button title={"Yelp"}/>
                <Button title={"PHSR"}/>
                <Button title={"Hilo"}/>
                <Button title={"Man"}/>
                <Button title={"Horn"}/>
                <Button title={"S.E._1"}/>
                <Button title={"S.E._2"}/>
                <Button title={"1.5x"}/>
                <Button title={"Siren"}/>
            </div>
        </div>
    );
};

export default ControlPanel;