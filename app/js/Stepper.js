const { useState } = React;

export default function Stepper({id, onComplete }) {
  const [step, setStep] = useState(1);
  // TEMP: DEV
  const user_info = {
    height: 170,
    weight: 60,
    smoker: false,
    metabolism: "medium",
    age: 25
  };

  const handleNextStep = () => {
    if (step < 2) {
      setStep(step + 1); // Move to the next step
    } else {
      onComplete(); // Notify parent to show LoadingScreen
      console.log("User info:", user_info);
      console.log(id);
      Shiny.setInputValue(`${id}`, user_info); // Trigger the calculation
    }
  };

  return (
    <div className="stepper-card">
      <div className="progress-bar">
        <div
          className="progress"
          style={{ width: `${(step / 2) * 100}%` }}
        ></div>
      </div>
      <div className="step-content">
        {step === 1 && (
          <div className="step">
            <p>Step 1 of 2</p>
            {/*<input type="text" placeholder="Enter your name" />*/}
            <p>
              <i>TBD: User info</i>
            </p>
            <button onClick={handleNextStep}>Next</button>
          </div>
        )}
        {step === 2 && (
          <div className="step">
            <p>Step 2 of 2</p>
            {/*<input type="email" placeholder="Enter your email" />*/}
            <p>
              <i>TBD: Intake</i>
            </p>
            <button onClick={handleNextStep}>Calculate</button>
          </div>
        )}
      </div>
    </div>
  );
}
