const { useEffect, useState } = React;
const { PiCoffeeBeanFill } = require('react-icons/pi');

export default function LoadingScreen() {
  return (
    <div className="loading-screen">
      <PiCoffeeBeanFill />
    </div>
  );
}
