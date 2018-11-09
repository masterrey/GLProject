using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Car : MonoBehaviour {
    public WheelCollider[] wheelsf;
    public WheelCollider[] wheelsr;
    public float motorpower = 100;
    // Use this for initialization
    void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		foreach(WheelCollider col in wheelsf)
        {
            col.motorTorque = Input.GetAxis("Vertical")*-motorpower;
            col.steerAngle = Input.GetAxis("Horizontal") * 40;
        }
        foreach (WheelCollider col in wheelsr)
        {
            col.motorTorque = Input.GetAxis("Vertical") * -motorpower;
        }
    }
}
