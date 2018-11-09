using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Wheel : MonoBehaviour {
    WheelCollider col;
    public GameObject mesh;
	// Use this for initialization
	void Start () {
        col=GetComponent<WheelCollider>();
        
    }
	
	// Update is called once per frame
	void Update () {
        Vector3 wpos;
        Quaternion wrot;
        col.GetWorldPose(out wpos,out  wrot);
        mesh.transform.position = wpos;
        mesh.transform.rotation = wrot;
	}
}
