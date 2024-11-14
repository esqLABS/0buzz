const { useState, useEffect } = React;
const Intake = require('./components/Intake.js').default;

export default function EditIntakeData({id, init_shiny_data, coffee_type_options}) {
  console.log("initShinyData: ", init_shiny_data);

    const [intakes, setIntakes] = useState(init_shiny_data);

    const handleIntakeChange = (updatedIntakes) => {
        setIntakes(updatedIntakes);
        Shiny.setInputValue(id, {intakes: updatedIntakes});
        setShinyData(prevData => ({
            ...prevData,
            intakes: updatedIntakes
        }));
    };

    const handleAddIntake = () => {
        const newIntakes = [...intakes, { type: {}, time: '', selected: true }];
        setIntakes(newIntakes);
        Shiny.setInputValue(id, {intakes: newIntakes});
        setShinyData(prevData => ({
            ...prevData,
            intakes: newIntakes
        }));
    };

    const handleRemoveIntake = (indexToRemove) => {
      const updatedIntakes = intakes.filter((_, index) => index !== indexToRemove);
      setIntakes(updatedIntakes); // or however you're managing state
      Shiny.setInputValue(id, {intakes: updatedIntakes});
    };


    return(
      <div id={id}>

           <Intake
              intakes={intakes}
              onIntakeChange={handleIntakeChange}
              onAddIntake={handleAddIntake}
              onRemoveIntake={handleRemoveIntake}
              coffeeTypeOptions={coffee_type_options}
              showInitIntake={false}
              showEditIntake={true}
              startCalc={() => {}}
            />

      </div>
    );

}
