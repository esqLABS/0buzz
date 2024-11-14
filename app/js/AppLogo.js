const { useEffect, useState } = React;

export default function AppLogo({ onAnimationComplete }) {
  const [moveToTop, setMoveToTop] = useState(false);
  const [finalState, setFinalState] = useState(false);

  useEffect(() => {
    // Start the move-to-top animation after 4 seconds
    const moveTimer = setTimeout(() => {
      setMoveToTop(true);
      // onAnimationComplete(); // Notify parent that animation is complete
    }, 2000);

    // Set to final state after the transition (1 second after moveToTop)
    const finalTimer = setTimeout(() => {
      setFinalState(true);
      onAnimationComplete();
    }, 2750); // Delayed 1 second after moveTimer

    return () => {
      clearTimeout(moveTimer);
      clearTimeout(finalTimer);
    };
  }, [onAnimationComplete]);

  return (
    <div
      className={`logo-container ${moveToTop ? 'move-to-top' : ''} ${finalState ? 'final-state' : ''}`}
    >
      <h1 className="logo-text">Caffeine App</h1>
    </div>
  );
}
