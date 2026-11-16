import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

/** Educational safety check for a fixed hospital resource-allocation snapshot. */
public final class HospitalDeadlock {
    private static final long MAX_MATRIX_CELLS = 1_000_000;

    private HospitalDeadlock() { }

    public static void main(String[] args) {
        int status = run(args, System.out);
        if (status != 0) System.exit(status);
    }

    private static int run(String[] args, PrintStream out) {
        Path inputFile = null;
        boolean trace = false;
        try {
            for (int i = 0; i < args.length; i++) {
                switch (args[i]) {
                    case "--help":
                        out.println("Usage: java HospitalDeadlock [--input FILE] [--trace]");
                        out.println("Input: n, m, Allocation[n][m], Maximum[n][m], Available[m].");
                        out.println("Use whitespace-separated non-negative integers; n and m must be positive.");
                        return 0;
                    case "--trace":
                        trace = true;
                        break;
                    case "--input":
                        if (++i >= args.length || inputFile != null) {
                            throw new IllegalArgumentException("Use --input once, followed by a file path.");
                        }
                        inputFile = Path.of(args[i]);
                        break;
                    default:
                        throw new IllegalArgumentException("Unknown option: " + args[i]);
                }
            }

            out.println("HOSPITAL RESOURCE MANAGEMENT - BANKER'S SAFETY ALGORITHM");
            out.println("Kaviya Dharshini | USN: 25BTRAD051");
            out.println("Educational simulation of a fixed resource-allocation snapshot.");
            try (Scanner input = inputFile == null ? new Scanner(System.in) : new Scanner(inputFile)) {
                out.print("Enter number of processes: ");
                int n = readNonNegative(input, "number of processes");
                out.print("Enter number of resource types: ");
                int m = readNonNegative(input, "number of resource types");
                if (n == 0 || m == 0) {
                    throw new IllegalArgumentException("Process and resource counts must be positive.");
                }
                if ((long) n * m > MAX_MATRIX_CELLS) {
                    throw new IllegalArgumentException("This educational console supports at most "
                            + MAX_MATRIX_CELLS + " cells per matrix.");
                }

                int[][] allocation = new int[n][m];
                int[][] maximum = new int[n][m];
                int[][] need = new int[n][m];
                out.println("\nEnter Allocation Matrix (one row per process):");
                readMatrix(input, allocation, "Allocation");
                out.println("Enter Maximum Demand Matrix (one row per process):");
                readMatrix(input, maximum, "Maximum");
                for (int i = 0; i < n; i++) {
                    for (int j = 0; j < m; j++) {
                        if (maximum[i][j] < allocation[i][j]) {
                            throw new IllegalArgumentException("Maximum demand cannot be less than allocation"
                                    + " at P" + i + ", resource " + j + ".");
                        }
                        need[i][j] = maximum[i][j] - allocation[i][j];
                    }
                }
                out.println("Enter Available Resources:");
                long[] available = new long[m];
                for (int j = 0; j < m; j++) {
                    available[j] = readNonNegative(input, "Available[" + j + "]");
                }
                // A file represents exactly one snapshot. Interactive mode does not wait for EOF.
                if (inputFile != null && input.hasNext()) {
                    throw new IllegalArgumentException("Unexpected extra input after the Available vector.");
                }

                out.println("\nNeed Matrix (Maximum - Allocation):");
                for (int i = 0; i < n; i++) {
                    out.print("P" + i + ":");
                    for (int value : need[i]) out.print(" " + value);
                    out.println();
                }

                long[] work = available.clone();
                boolean[] finish = new boolean[n];
                List<Integer> sequence = new ArrayList<>();
                if (trace) out.println("\nInitial Work: " + Arrays.toString(work));
                while (sequence.size() < n) {
                    boolean found = false;
                    for (int i = 0; i < n; i++) {
                        if (finish[i] || !canFinish(need[i], work)) continue;
                        if (trace) {
                            out.print("P" + i + " can finish: Need " + Arrays.toString(need[i])
                                    + " <= Work " + Arrays.toString(work));
                        }
                        for (int j = 0; j < m; j++) work[j] += allocation[i][j];
                        finish[i] = true;
                        sequence.add(i);
                        found = true;
                        if (trace) out.println("; release Allocation -> Work " + Arrays.toString(work));
                    }
                    if (!found) break;
                }

                if (sequence.size() == n) {
                    out.println("\nSystem is in a SAFE state.");
                    out.print("Safe sequence: ");
                    for (int i = 0; i < sequence.size(); i++) {
                        if (i > 0) out.print(" -> ");
                        out.print("P" + sequence.get(i));
                    }
                    out.println();
                } else {
                    out.println("\nSystem is in an UNSAFE state.");
                    out.println("No safe sequence exists for this snapshot.");
                    out.println("An unsafe state does not necessarily mean deadlock has already occurred.");
                    if (trace) {
                        out.println("Final Work: " + Arrays.toString(work));
                        out.print("Unfinished processes:");
                        for (int i = 0; i < n; i++) if (!finish[i]) out.print(" P" + i);
                        out.println();
                    }
                }
            }
            return 0;
        } catch (IllegalArgumentException | IOException exception) {
            out.println("\nInvalid input: " + exception.getMessage());
            return 1;
        }
    }

    private static boolean canFinish(int[] need, long[] work) {
        for (int j = 0; j < need.length; j++) if (need[j] > work[j]) return false;
        return true;
    }

    private static void readMatrix(Scanner input, int[][] matrix, String name) {
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                matrix[i][j] = readNonNegative(input, name + "[" + i + "][" + j + "]");
            }
        }
    }

    private static int readNonNegative(Scanner input, String label) {
        if (!input.hasNext()) throw new IllegalArgumentException("Missing integer for " + label + ".");
        if (!input.hasNextInt()) {
            throw new IllegalArgumentException("Expected a 32-bit integer for " + label
                    + ", received '" + input.next() + "'.");
        }
        int value = input.nextInt();
        if (value < 0) throw new IllegalArgumentException(label + " cannot be negative.");
        return value;
    }
}
