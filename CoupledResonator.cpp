#include "SC_PlugIn.h"
#include <math.h>

//  Created by So Oishi on 29/10/14.


// BASIC ADMINISTRATION

static InterfaceTable *ft;

struct CoupledResonator : public Unit
{
    float displacement1;
    float displacement2;
    float velocity1;
    float velocity2;
    float acceleration1;
    float acceleration2;
    float forceSpring1;
    float forceSpring2;
    float forceSpring3;
};

// declare unit generator functions
extern "C"
{
    void CoupledResonator_Ctor(CoupledResonator *unit);
    void CoupledResonator_next(CoupledResonator *unit, int inNumSamples);
};

//////////////////////////////////////////////////////////////////

// CONSTRUCTOR

void CoupledResonator_Ctor(CoupledResonator *unit)
{
    
    SETCALC(CoupledResonator_next);

    unit->displacement1 = ZIN0(0);
    unit->displacement2 = ZIN0(1);
    unit->velocity1 = ZIN0(2);
    unit->velocity2 = ZIN0(3);
    unit->acceleration1 = ZIN0(4);
    unit->acceleration2 = ZIN0(5);
    unit->forceSpring1 = ZIN0(6);
    unit->forceSpring2 = ZIN0(7);
    unit->forceSpring3 = ZIN0(8);
    
    CoupledResonator_next(unit, 1);
}

//////////////////////////////////////////////////////////////////

// UGEN CALCULATION

void CoupledResonator_next(CoupledResonator *unit, int inNumSamples)
{
    // get the pointer to the output buffer
    float *out = ZOUT(0);
    
    float displacement1 = unit->displacement1;
    float displacement2 = unit->displacement2;
    float velocity1 = unit->velocity1;
    float velocity2 = unit->velocity2;
    float acceleration1 = unit->acceleration1;
    float acceleration2 = unit->acceleration2;
    float forceSpring1 = unit->forceSpring1;
    float forceSpring2 = unit->forceSpring2;
    float forceSpring3 = unit->forceSpring3;
    float mass1 = ZIN0(9);
    float mass2 = ZIN0(10);
    float b1 = ZIN0(11);
    float b2 = ZIN0(12);
    float b3 = ZIN0(13);
    short outputChoice = ZIN0(14);
    float outval;

    LOOP(inNumSamples,
          acceleration1 = (forceSpring1 - forceSpring2) / mass1;
          acceleration2 = (forceSpring2 + forceSpring3) / mass2;
          velocity1 = velocity1 + acceleration1 / SAMPLERATE;
          velocity2 = velocity2 + acceleration2 / SAMPLERATE;
          displacement1 = displacement1 + velocity1 / SAMPLERATE;
          displacement2 = displacement2 + velocity2 / SAMPLERATE;
          forceSpring1 = - b1 * displacement1;
          forceSpring2 = - b2 * (displacement2 - displacement1);
          forceSpring3 = - b3 * displacement2;
          switch (outputChoice) {
             case 0: outval = displacement1;
                 break;
             case 1: outval = displacement2;
                 break;
             case 2: outval = velocity1;
                 break;
             case 3: outval = velocity2;
                 break;
             case 4: outval = acceleration1;
                 break;
             case 5: outval = acceleration2;
                 break;
             default: outval = displacement1;
         };
          ZXP(out) = outval;
         )
    unit->displacement1 = displacement1;
    unit->displacement2 = displacement2;
    unit->velocity1 = velocity1;
    unit->velocity2 = velocity2;
    unit->acceleration1 = acceleration1;
    unit->acceleration2 = acceleration2;
    unit->forceSpring1 = forceSpring1;
    unit->forceSpring2 = forceSpring2;
    unit->forceSpring3 = forceSpring3;
}

////////////////////////////////////////////////////////////////////

// LOAD FUNCTION

// the load function is called by the host when the plugin is loaded

PluginLoad(CoupledResonator)
{
    ft = inTable;
    
    DefineSimpleUnit(CoupledResonator);
}

////////////////////////////////////////////////////////////////////

