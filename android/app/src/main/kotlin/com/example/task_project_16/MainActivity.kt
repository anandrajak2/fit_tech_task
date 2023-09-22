package com.example.task_project_16

import android.Manifest
import android.bluetooth.BluetoothAdapter
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
class MainActivity: FlutterActivity() {
    private val CHANNEL = "samples.flutter.dev/battery"
    private val BLUETOOTH_CONNECT_PERMISSION_CODE = 123
    private var PERMISSION_MESSAGE = "Please Wait"
//    private lateinit var activityBinding: ActivityPluginBinding
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
               /* "getBatteryLevel" -> {
                    val batteryLevel = getBatteryLevel()
                    if (batteryLevel != -1) {
                        result.success(batteryLevel)
                    } else {
                        result.error("UNAVAILABLE", "Battery level not available.", null)
                    }
                }
                "enableBluetooth" -> enableBluetooth(result)
                "disableBluetooth" -> disableBluetooth(result)
                else -> result.notImplemented()*/
                "checkPermission"->{
                    if (ActivityCompat.checkSelfPermission(
                            this,
                            Manifest.permission.BLUETOOTH_CONNECT
                        ) != PackageManager.PERMISSION_GRANTED
                    ) {
                        ActivityCompat.requestPermissions(
                            this,
                            arrayOf(Manifest.permission.BLUETOOTH_CONNECT),
                            BLUETOOTH_CONNECT_PERMISSION_CODE
                        )
                        result.success(true)
                        // TODO: Consider calling
                        //    ActivityCompat#requestPermissions
                        // here to request the missing permissions, and then overriding
                        //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                        //                                          int[] grantResults)
                        // to handle the case where the user grants the permission. See the documentation
                        // for ActivityCompat#requestPermissions for more details.


//                        result.error("Bluetooth Permission denied","Bluetooth doesn't have permission",null)
                    }else{
                        result.success(true)
                    }
                }
                "checkBluetoothStatus" -> {
                    val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
                    result.success(bluetoothAdapter?.isEnabled == true)
                }
                "toggleBluetooth" -> {
                    val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
                    if (bluetoothAdapter == null) {
                        result.error("Bluetooth not supported", null, null)
                        return@setMethodCallHandler
                    }
                    if (bluetoothAdapter.isEnabled) {
                        if (ActivityCompat.checkSelfPermission(
                                this,
                                Manifest.permission.BLUETOOTH_CONNECT
                            ) != PackageManager.PERMISSION_GRANTED
                        ) {
                            // TODO: Consider calling
                            //    ActivityCompat#requestPermissions
                            // here to request the missing permissions, and then overriding
                            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                            //                                          int[] grantResults)
                            // to handle the case where the user grants the permission. See the documentation
                            // for ActivityCompat#requestPermissions for more details.
                            result.error("Bluetooth Permission denied","Bluetooth doesn't have permission",null)
                        }
                        bluetoothAdapter.disable()
                        result.success(false)
                    } else {
                        val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
                        startActivityForResult(enableBtIntent, 1)
                    }
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }





   /*  fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityBinding = binding
    }*/
    private fun getBatteryLevel(): Int {
        // Your code for obtaining battery level
        // ...
//        val batteryLevel: Int
//        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
//            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
//            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
//        } else {
//            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
//            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
//        }

        return 0;
    }

    private fun enableBluetooth(): String {
        val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()

        if (!isBluetoothConnectPermissionGranted()) {
            requestBluetoothConnectPermission()
            return "Requesting Bluetooth permission..."
        }

        if (!bluetoothAdapter.isEnabled) {
            if (ActivityCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
                // TODO: Consider calling
                //    ActivityCompat#requestPermissions
                // here to request the missing permissions, and then overriding
                //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                //                                          int[] grantResults)
                // to handle the case where the user grants the permission. See the documentation
                // for ActivityCompat#requestPermissions for more details.
                return "Permission Issue"
            }
            bluetoothAdapter.enable()
            return "Bluetooth is now enabled."
        } else {
            return "Bluetooth is already enabled."
        }
    }

    private fun isBluetoothConnectPermissionGranted(): Boolean {
        return ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.BLUETOOTH_CONNECT
        ) == PackageManager.PERMISSION_GRANTED
    }

    private fun requestBluetoothConnectPermission() {
        ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.BLUETOOTH_CONNECT),
                BLUETOOTH_CONNECT_PERMISSION_CODE
        )
    }

    override fun onRequestPermissionsResult(
            requestCode: Int,
            permissions: Array<out String>,
            grantResults: IntArray
    ) {
        if (requestCode == BLUETOOTH_CONNECT_PERMISSION_CODE) {
            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                enableBluetooth()
            } else {
                PERMISSION_MESSAGE = "Bluetooth Enable Failed. Please Check Permission"
                // Handle the case where the user denied the permission
            }
        }
    }

    private fun showMessage(message: String) {
        Toast.makeText(applicationContext, message, Toast.LENGTH_LONG).show()
    }
/*    private fun enableBluetooth(result: Result) {
        val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
        if (bluetoothAdapter != null) {
            if (!bluetoothAdapter.isEnabled) {
                val enableBluetoothIntent = activityBinding.activity?.packageName?.let {
                    activityBinding.activity?.packageManager?.getLaunchIntentForPackage(
                        it
                    )
                }
                enableBluetoothIntent?.action = BluetoothAdapter.ACTION_REQUEST_ENABLE
                activityBinding.activity?.startActivity(enableBluetoothIntent)
            }
            result.success(true)
        } else {
            result.error("BLUETOOTH_UNSUPPORTED", "Bluetooth is not supported on this device.", null)
        }
    }*/
 /*   private fun disableBluetooth(result: Result) {
        val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
        if (bluetoothAdapter != null) {
            if (bluetoothAdapter.isEnabled) {
                if (ActivityCompat.checkSelfPermission(
                        this,
                        Manifest.permission.BLUETOOTH_CONNECT
                    ) != PackageManager.PERMISSION_GRANTED
                ) {
                    // TODO: Consider calling
                    //    ActivityCompat#requestPermissions
                    // here to request the missing permissions, and then overriding
                    //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                    //                                          int[] grantResults)
                    // to handle the case where the user grants the permission. See the documentation
                    // for ActivityCompat#requestPermissions for more details.
                    return
                }
                bluetoothAdapter.disable()
            }
            result.success(true)
        } else {
            result.error("BLUETOOTH_UNSUPPORTED", "Bluetooth is not supported on this device.", null)
        }
    }*/

}
