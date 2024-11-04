const { useEffect, useState } = React;
const AppLogo = require('./AppLogo.js').default;
const Stepper = require('./Stepper.js').default;
const LoadingScreen = require('./LoadingScreen.js').default;

export default function IntroScreen({ id, init_shiny_data, ethinicity_options, metabolism_options }) {
  const [showLoading, setShowLoading] = useState(false);
  const [showStepper, setShowStepper] = useState(false);

  const handleLogoAnimationComplete = () => {
    setShowStepper(true); // Show Stepper when logo animation completes
  };

  const handleStepperComplete = () => {
    setShowLoading(true); // Show LoadingScreen after Stepper completes
  };

  return (
    <div>
      {showLoading ? (
        <LoadingScreen />
      ) : (
        <div className="app-container">
          <AppLogo onAnimationComplete={handleLogoAnimationComplete} />
          {showStepper && <Stepper id={id}
                                   initShinyData={init_shiny_data}
                                   onComplete={handleStepperComplete}
                                   ethinicityOptions={ethinicity_options}
                                   metabolismOptions={metabolism_options}
                          />}
        </div>
      )}
    </div>
  );
}
