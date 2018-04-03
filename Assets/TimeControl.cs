using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TimeControl : MonoBehaviour {

    Rigidbody rb;
    private float _timeScale = 1.0f;
    public float timeScale {
        get { return _timeScale; }
        set {

            rb.mass *= timeScale;
            rb.velocity /= timeScale;
            rb.angularVelocity /= timeScale;

            _timeScale = Mathf.Abs(value);

            rb.mass /= timeScale;
            rb.velocity *= timeScale;
            rb.angularVelocity *= timeScale;
        }
    }
    // Use this for initialization
    void Start() {
        rb = GetComponent<Rigidbody>();
    }
    /*
    void OnTriggerEnter(Collider collider) {
        if (collider.gameObject.CompareTag("InfluenceField")) {
            timeScale = 0.01f;
        }
    }
    void OnTriggerExit(Collider collider) {
        if (collider.gameObject.CompareTag("InfluenceField")) {
            timeScale = 1.0f;
        }
    }
    */
    // Update is called once per frame
    void Update () {
       
	}
}
